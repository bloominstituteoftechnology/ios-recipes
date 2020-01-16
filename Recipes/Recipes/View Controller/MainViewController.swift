//
//  MainViewController.swift
//  Recipes
//
//  Created by Eoin Lavery on 15/01/2020.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
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
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    let networkClient = RecipesNetworkClient()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("Error when attempting to fetch recipes")
                return
            }
            
            guard let recipes = recipes else {
                print("Error: Unable to load recipes")
                return
            }
            
            self.allRecipes = recipes
        }
        searchBar.delegate = self
    }
    
    //MARK: - Private Functions
    private func filterRecipes() {
        guard let searchText = searchBar.text,
            searchText != "" else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.instructions.lowercased().contains(searchText.lowercased())}
    }
    
    //MARK: - IBActions
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}

//MARK: - Protocol Extensions
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterRecipes()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filterRecipes()
    }
    
}
