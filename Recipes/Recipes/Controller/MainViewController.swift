//
//  MainViewController.swift
//  Recipes
//
//  Created by alfredo on 1/14/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion: { (recipes, error) in
            let recipes = recipes
            let thereIsAnError = error == nil ? false : true
            if thereIsAnError{
                NSLog("\(error!)")
            }
            else{
                DispatchQueue.main.async{
                    self.allRecipes = recipes!
                }
            }
        })
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []{
        didSet{
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController?{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = []{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func textFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "containerView'sTable" else { return }
        guard let showTableVC = segue.destination as? RecipesTableViewController else { return }
        
        recipesTableViewController = showTableVC
    }
    
    //MARK: - Methods
    
    func filterRecipes(){
        let textFieldText: String! = textField.text == nil ? "" : textField.text!

        switch true{
        case textFieldText != "" && textFieldText != nil:
            filteredRecipes = allRecipes.filter {
                $0.name.localizedCaseInsensitiveContains(textFieldText) || $0.instructions.localizedCaseInsensitiveContains(textFieldText)
            }
        default:
            self.filteredRecipes = allRecipes
        }
    }
}

