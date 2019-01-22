//
//  MainViewController.swift
//  Recipes
//
//  Created by Moses Robinson on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("error getting recipes: \(error)")
                return
            } else {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    @IBAction func searchRecipe(_ sender: Any) {
        searchRecipesField.resignFirstResponder()
        filterRecipes()
    }
    
    private func filterRecipes() {
        guard let searchTerm = searchRecipesField.text?.lowercased() else { return }
        
        if searchTerm.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm.lowercased()) || $0.instructions.contains(searchTerm.lowercased())
            }
        }
    }
    
    private func updateViews() {
        if filteredRecipes.count == 1 {
            title = "Recipe"
        } else if filteredRecipes.count == 0 {
            title = "No Recipes Found"
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            
            recipesTableViewController = recipesTableVC
        }
    }
    
    //MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.filterRecipes()
            }
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
            updateViews()
        }
    }
    
    @IBOutlet weak var searchRecipesField: UITextField!
    
}
