//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael on 1/13/20.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    @IBAction func searchUsersRecipe(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        if let userSearch = searchTextField.text, !userSearch.isEmpty {
            filteredRecipes = allRecipes.filter { $0.name.contains(userSearch) || $0.instructions.contains(userSearch) }
        } else {
            filteredRecipes = allRecipes
        }
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromViewContainerSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
