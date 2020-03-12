//
//  MainViewController.swift
//  Recipes
//
//  Created by Waseem Idelbi on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var searchTextField: UITextField!
    
    @IBAction func searchFieldAction(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    //MARK: -Properties-
    
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
    
    
    //MARK: -Methods-
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    func filterRecipes() {
        guard let searchTerm = searchTextField.text,
            !searchTerm.isEmpty else {
                filteredRecipes = allRecipes
                return
        }
        let searchResults = allRecipes.filter { (recipe) -> Bool in
            var resultWasFound = false
            if recipe.name.contains(searchTerm) {
                resultWasFound = true
            }
            if recipe.instructions.contains(searchTerm) {
                resultWasFound = true
            }
            return resultWasFound
        }
        filteredRecipes = searchResults
    }
    
    
} //End of class
