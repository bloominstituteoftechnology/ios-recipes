//
//  MainViewController.swift
//  Recipes
//
//  Created by Elizabeth Thomas on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("Error loading recipes: \(error!)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
                print(self.allRecipes)
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var recipeTextField: UITextField!

    // MARK: - IBActions
    @IBAction func recipeTextFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // HELP
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            guard let recipeTableViewVC = segue.destination as? RecipesTableViewController else { return }
        }
    }
    
    func filterRecipes() {
        guard let searchTerm = recipeTextField.text, !searchTerm.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
            filteredRecipes = filteredRecipes.filter{
                $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)
        }
    }
}
