//
//  MainViewController.swift
//  Recipes
//
//  Created by Jessie Ann Griffin on 9/3/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: IBOutlets    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: Properties
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
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
    }
    
    // MARK: Processing - Filtering and sorting
    private func filterRecipes() {
        guard let searchItem = searchTextField.text, !searchItem.isEmpty else { return }
        if searchItem.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.name == searchItem || $0.instructions.contains(searchItem)}
        }
    }
    
    // MARK: Actions
    @IBAction func searchTextEntered(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededTableViewSegue" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableVC.recipesTableViewController = recipesTableViewController
        }
    }
}
