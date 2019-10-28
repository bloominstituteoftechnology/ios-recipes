//
//  MainViewController.swift
//  Recipes
//
//  Created by Jon Bash on 2019-10-28.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    let localStoreController = LocalRecipesStoreController.shared
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
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

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let didLoadLocalRecipes = localStoreController.didLoadRecipesFromLocalStore()
        if didLoadLocalRecipes {
            allRecipes = localStoreController.recipes
        } else {
            networkClient.fetchRecipes { (recipes, error) in
                if let error = error {
                    print("Error fetching recipes: \(error)")
                    return
                } else if let recipes = recipes {
                    self.allRecipes = recipes
                    self.localStoreController.recipes = self.allRecipes
                    self.localStoreController.saveRecipesToLocalStore()
                }
            }
        }
    }
    
    @IBAction func search(_ sender: UITextField) {
        searchField.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.searchField.text, !searchTerm.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            self.filteredRecipes = self.allRecipes.filter {
                $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeListEmbedSegue",
            let recipesTableVC = segue.destination as? RecipesTableViewController {
            
            recipesTableViewController = recipesTableVC
        }
    }
}
