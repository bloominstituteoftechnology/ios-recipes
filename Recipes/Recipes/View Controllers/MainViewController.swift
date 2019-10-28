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

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                print("Error fetching recipes: \(error)")
                return
            } else if let recipes = recipes {
                self.allRecipes = recipes
            }
        }
    }
    
    @IBAction func search(_ sender: UITextField) {
        searchField.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let searchTerm = searchField.text, !searchTerm.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter {
            $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)
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
