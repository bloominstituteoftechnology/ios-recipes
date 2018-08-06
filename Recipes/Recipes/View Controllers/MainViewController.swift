//
//  MainViewController.swift
//  Recipes
//
//  Created by De MicheliStefano on 06.08.18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error while fetching recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    // MARK: - Actions
    
    @IBAction func searchRecipeOnEdit(_ sender: Any) {
        filterRecipes()
    }
    
    @IBAction func searchRecipeOnReturn(_ sender: UITextField) {
        filterRecipes()
    }
    
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchText = self.searchTextField?.text else { return }
            if searchText.isEmpty {
                self.filteredRecipes = self.allRecipes
                return
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().range(of: searchText) != nil }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
            recipesTableViewController?.networkClient = networkClient
        }
    }
    
    // MARK: - Properties
    
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
    
    let networkClient = RecipesNetworkClient()
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    @IBOutlet weak var searchTextField: UITextField!
}
