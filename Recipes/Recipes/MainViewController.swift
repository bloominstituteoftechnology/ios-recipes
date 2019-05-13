//
//  MainViewController.swift
//  Recipes
//
//  Created by Mitchell Budge on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error gathering recipes: \(error)")
                return
            }
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        }
    } // end of view did load
    
    func filterRecipes() {
        guard let searchTerm = self.searchTextField.text, !searchTerm.isEmpty else {
            self.filteredRecipes = self.allRecipes
            let searchRecipes = self.allRecipes.filter ( { $0.name != nil || $0.instructions != nil } )
            self.filteredRecipes = searchRecipes
            return
        }
    } // end of filter recipes
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchTextFieldEdited(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableSegue" {
            let recipesTVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTVC
        }
    } // end of prepare for segue

    var recipesTableViewController: RecipesTableViewController?
}
