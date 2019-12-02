//
//  MainViewController.swift
//  Recipes
//
//  Created by Chad Rutherford on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { [weak self] recipes, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            guard let recipes = recipes, let self = self else { return }
            self.allRecipes = recipes
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private
    private func filterRecipes() {
        guard let term = titleTextField.text, !term.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { $0.name == term }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.recipeEmbed:
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipesTableVC
        default:
            break
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Actions
    @IBAction func textFieldEditingEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
        filterRecipes()
    }
}
