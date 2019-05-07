//
//  MainViewController.swift
//  Recipes
//
//  Created by Sameera Roussi on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var receipeSearchBar: UISearchBar!
    
    private var recipesTableViewController: RecipesTableViewController!
    
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    private var filteredRecipes: [Recipe] = [] {
        
        didSet {
           filterRecipes()
        }
    }
  
    let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearching: Bool = false
    
    
    // MARK: - View states
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Fetch the recipes from the network
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error loading recipes \(error)")
                return
            }
        
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
        
        // Set up searhbar
        implementSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set / reset searchbar
        isSearching = false
        searchController.searchBar.text = ""
        recipesTableViewController.recipes = allRecipes
    }
    
    // Create the searchbar
    func implementSearchBar() {
       // let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a yummy recipe!"
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }

    func filterRecipes() {
        // If we did a search only display the search results
        
        recipesTableViewController.recipes = isSearching ? filteredRecipes : allRecipes
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipeTableView" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    
    // Filter the recipes
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            isSearching = true
            filteredRecipes = allRecipes.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
        
        filterRecipes()
    }
}

