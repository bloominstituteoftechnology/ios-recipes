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
    @IBOutlet var searchTextField: UITextField!
    
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
            guard let searchText = self.searchTextField.text else { return }
            
            if searchText.isEmpty {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText) }
            }
        }
    }
    
}
