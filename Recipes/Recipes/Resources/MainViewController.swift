//
//  MainViewController.swift
//  Recipes
//
//  Created by Shawn Gee on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlets
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Private
    
    private var networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] { didSet { filterRecipes() } }
    private var filteredRecipes: [Recipe] = [] { didSet { recipesTVC?.recipes = filteredRecipes } }
    
    private var recipesTVC: RecipesTableViewController? { didSet { recipesTVC?.recipes = filteredRecipes } }
    
    private func fetchRecipes() {
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("There was an error fetching recipes: \(error)")
                return
            }
            
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    private func filterRecipes() {
        guard let searchText = searchBar.text,
              !searchText.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter {
            $0.name.localizedStandardContains(searchText) || $0.instructions.localizedStandardContains(searchText)
        }
    }
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipes()
        searchBar.delegate = self
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewController" {
            recipesTVC = segue.destination as? RecipesTableViewController
        }
    }
}


//MARK: - Search Bar Delegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterRecipes()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
