//
//  MainViewController.swift
//  Recipes
//
//  Created by Nichole Davidson on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    func filterRecipes() {
        var updatedRecipes: [Recipe]
        
        guard case searchTextField.text = searchTextField.text else {
            if searchTextField.text != nil {
                filteredRecipes = allRecipes
            } else {
                updatedRecipes = allRecipes.filter { $0.name == "\(searchTextField.text ?? "")" }
                updatedRecipes = allRecipes.filter { $0.instructions == "\(searchTextField.text ?? "")" }
            }
            
            return
        }
        
        updatedRecipes = self.filteredRecipes
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            guard let viewRecipeVC = segue.destination as? RecipesTableViewController else { return }
            viewRecipeVC.recipes = allRecipes
        }
    }
}
