//
//  MainViewController.swift
//  Recipes
//
//  Created by Sameera Roussi on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    
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
    
    
    // MARK: - View states
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        receipeSearchBar.delegate = self

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
    }
    
    
    // MARK: - Data Manipulation
    
    func filterRecipes() {
        recipesTableViewController.recipes = allRecipes
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        receipeSearchBar.resignFirstResponder()
       // filterRecipes()
        
        guard let findThisRecipe = receipeSearchBar.text, !findThisRecipe.isEmpty else {
            return
        }
        
//        searchBar.text = ""
//        searchBar.placeholder = findThisRecipe
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipeTableView" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }


}
