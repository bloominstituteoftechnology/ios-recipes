//
//  MainViewController.swift
//  Recipes
//
//  Created by Alexander Supe on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] { didSet { filterRecipes() } }
    var recipesTableViewController: RecipesTableViewController? { didSet { recipesTableViewController?.recipes = filteredRecipes } }
    var filteredRecipes: [Recipe] = [] { didSet { recipesTableViewController?.recipes = filteredRecipes } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes {
            if ($1 != nil) {
                print("\(String(describing: $1))")
            } else {
                guard let newRecipes = $0 else { return }
                self.allRecipes = newRecipes
            }
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.textField.text, text != "" else { self.filteredRecipes = self.allRecipes; return }
            self.filteredRecipes = self.allRecipes.filter({$0.name.contains(text) || $0.instructions.contains(text)})
        }
    }
    
    
    
    @IBAction func textFieldAction(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "embedSegue" {
        recipesTableViewController = segue.destination as? RecipesTableViewController
        }
        
    }
   

}
