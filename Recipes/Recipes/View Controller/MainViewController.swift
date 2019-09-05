//
//  MainViewController.swift
//  Recipes
//
//  Created by Eoin Lavery on 04/09/2019.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    let recipeController = RecipeController()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if recipeController.recipes.count > 0 {
            allRecipes = recipeController.recipes
            print("Array has Recipes.")
        } else {
            print("Array has no Recipes.")
            networkClient.fetchRecipes { recipe, error in
                if let error = error {
                    print("Could not load Recipes: \(error)")
                } else {
                    guard let recipes = recipe else { return }
                    self.allRecipes = recipes
                    self.recipeController.saveOnlineRecipes(recipesToSave: self.allRecipes)
                    self.recipeController.saveToPersistentStore()
                }
            }
        }
        recipeSearchBar.delegate = self
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }

    // MARK: - IBActions
    @IBAction func textFieldEnded(_ sender: Any) {
        self.resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Functions
    private func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchText = self.recipeSearchBar.text else { return }
            
            if searchText.isEmpty {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.instructions.lowercased().contains(searchText.lowercased()) }
            }
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterRecipes()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterRecipes()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
