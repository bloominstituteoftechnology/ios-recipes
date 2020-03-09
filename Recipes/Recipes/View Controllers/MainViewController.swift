//
//  MainViewController.swift
//  Recipes
//
//  Created by Shawn Gee on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Private
    
    private var networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] { didSet { filterRecipes() } }
    private var filteredRecipes: [Recipe] = [] { didSet { recipesTVC?.recipes = filteredRecipes } }
    
    private var recipesTVC: RecipesTableViewController? { didSet { recipesTVC?.recipes = filteredRecipes } }
    private let refreshControl = UIRefreshControl()
    
    @objc func refresh() {
        fetchRecipes(usingCache: false)
    }
    
    private func fetchRecipes(usingCache: Bool) {
        networkClient.fetchRecipes(usingCache: usingCache) { recipes, error in
            if let error = error {
                NSLog("There was an error fetching recipes: \(error)")
                return
            }
            
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func filterRecipes() {
        guard let searchText = recipesTVC?.searchBar.text,
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
        fetchRecipes(usingCache: true)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewController",
           let recipesTVC = segue.destination as? RecipesTableViewController {
            self.recipesTVC = recipesTVC
            recipesTVC.searchBar.delegate = self
            recipesTVC.refreshControl = refreshControl
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
