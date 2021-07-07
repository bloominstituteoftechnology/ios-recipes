//
//  MainViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // Outlets and Actions
    @IBOutlet weak var RecipeSearchField: UITextField!
    @IBAction func RecipeSearchAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    @IBAction func RecipeSearchField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // Variables and Constants
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if there is an error, if so, print the error and return.
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            // If recipes is empty return an empty Recipe array.
            self.allRecipes = recipes ?? []
        }
        // Do any additional setup after loading the view.
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.RecipeSearchField.text, !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            self.filteredRecipes = self.allRecipes.filter({ $0.name.lowercased().contains(text.lowercased()) || $0.instructions.lowercased().contains(text.lowercased()) })
            
        }
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }


}
