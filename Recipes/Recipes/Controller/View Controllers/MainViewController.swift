//
//  MainViewController.swift
//  Recipes
//
//  Created by Chad Rutherford on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    let defaults = UserDefaults.standard
    let recipeController = RecipeController()
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        fetchRecipes()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private
    
    private func fetchRecipes() {
        if defaults.bool(forKey: UserDefaultsKeys.recipesLoaded) {
            self.allRecipes = recipeController.recipes
        } else {
            networkClient.fetchRecipes { [weak self] recipes, error in
                if let error = error {
                    NSLog("\(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    guard let recipes = recipes, let self = self else { return }
                    self.allRecipes = recipes
                    self.recipeController.recipes = recipes
                    self.defaults.set(true, forKey: UserDefaultsKeys.recipesLoaded)
                    self.recipeController.saveToPersistentStore()
                }
            }
            
        }
    }
    
    private func filterRecipes() {
        guard let term = searchBar.text, !term.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { $0.name.contains(term.capitalized) }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.recipeEmbed:
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipesTableVC
        default:
            break
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filterRecipes()
    }
}
