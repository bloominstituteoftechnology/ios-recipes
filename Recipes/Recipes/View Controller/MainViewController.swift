//
//  MainViewController.swift
//  Recipes
//
//  Created by Nichole Davidson on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    func filterRecipes() {
        var updatedRecipes: [Recipe]
        
        
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        updatedRecipes = allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText)}
        
        self.filteredRecipes = updatedRecipes
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            guard let viewRecipeVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = viewRecipeVC
        }
    }
}
