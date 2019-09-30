//
//  MainViewController.swift
//  Recipes
//
//  Created by Gi Pyo Kim on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
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
            guard let recipesTalbeViewController = recipesTableViewController else { return }
            recipesTalbeViewController.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            guard let recipesTalbeViewController = recipesTableViewController else { return }
            recipesTalbeViewController.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                print("Error while fetching recipes: \(error)")
                return
            } else if let allRecipes = recipes {
                self.allRecipes = allRecipes
            }
        }
    }
    @IBAction func searched(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            if let recipesTVC = segue.destination as? RecipesTableViewController {
                recipesTableViewController = recipesTVC
            }
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.searchTextField.text, !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            self.filteredRecipes = self.allRecipes.filter({$0.name.contains(text) || $0.instructions.contains(text)})
        }
    }

}
