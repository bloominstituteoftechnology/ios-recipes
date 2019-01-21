//
//  MainViewController.swift
//  Recipes
//
//  Created by Nathanael Youngren on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    @IBAction func beginSearch(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableEmbed" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    func filterRecipes() {
        if let searchTerm = searchField.text {
            if searchTerm.isEmpty {
                filteredRecipes = allRecipes
            } else {
                filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
            }
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var searchField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.filterRecipes()
            }
        }
    }
    var recipesTableViewController: RecipesTableViewController?
}
