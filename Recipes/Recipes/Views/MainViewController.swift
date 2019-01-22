//
//  MainViewController.swift
//  Recipes
//
//  Created by Angel Buenrostro on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet{
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func textFieldAction(_ sender: Any) {
        DispatchQueue.global().async {
        self.resignFirstResponder()
            self.filterRecipes()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, Error) in
            if (Error != nil){ NSLog(Error as! String)
                return
            }
            else {
                self.allRecipes = recipes!
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func filterRecipes() {
        DispatchQueue.main.async{
            guard let text = self.textField.text, self.textField.text != "" else {
                self.filteredRecipes = self.allRecipes
            return
        }
            self.filteredRecipes = self.allRecipes.filter() { $0.name.contains(text) || $0.instructions.contains(text) }
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableSegue"{
            recipesTableViewController = segue.destination as? RecipesTableViewController
            
        }
    }

}
