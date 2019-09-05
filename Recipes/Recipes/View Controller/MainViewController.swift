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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { recipe, error in
            if let error = error {
                print("Could not load Recipes: \(error)")
            } else {
                guard let recipes = recipe else { return }
                self.allRecipes = recipes
            }
        }
        
        recipeSearchBar.delegate = self
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
