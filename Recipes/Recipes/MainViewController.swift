//
//  MainViewController.swift
//  Recipes
//
//  Created by Mitchell Budge on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error gathering recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    } // end of view did load
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func searchTextFieldEntered(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    func filterRecipes() {
        guard let searchTerm = searchTextField.text?.lowercased(), !searchTerm.isEmpty else {
            filteredRecipes = allRecipes
            return }
            let searchRecipes = allRecipes.filter ( { $0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm) } )
            filteredRecipes = searchRecipes
            return
    } // end of filter recipes
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableSegue" {
            let recipesTVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTVC
        }
    } // end of prepare for segue

    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
}





