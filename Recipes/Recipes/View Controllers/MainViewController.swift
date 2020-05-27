//
//  MainViewController.swift
//  Recipes
//
//  Created by morse on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    
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

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.allRecipes = recipes ?? []
                }
            }
        }
    }
    
    @IBAction func searchBarLeft(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let searchTerm = textField.text else { return }
        if searchTerm.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter({
                $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)
            })
        }
    }
    
    // MARK: - Navigation

    // This is MainViewController - 5.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeTableView" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
}
