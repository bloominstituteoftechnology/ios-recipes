//
//  MainViewController.swift
//  Recipes
//
//  Created by Elizabeth Thomas on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("Error loading recipes: \(error!)")
                return
            }
            guard let recipes = recipes else {
                print("Error loading recipes: The recipes array was nil.")
                return
            }
            self.allRecipes = recipes
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var recipeTextField: UITextField!

    // MARK: - IBActions
    @IBAction func recipeTextFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // HELP
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            guard let recipeTableViewVC = segue.destination as? RecipesTableViewController else { return }
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if self.recipeTextField.text == nil || self.recipeTextField.text == "" {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.filteredRecipes.filter({ (searchTerm) -> Bool in
                    self.allRecipes.contains(searchTerm)
                })
            }
        }
    }
}
