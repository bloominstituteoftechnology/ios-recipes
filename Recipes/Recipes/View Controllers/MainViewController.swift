//
//  MainViewController.swift
//  Recipes
//
//  Created by Paul Yi on 1/28/19.
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
    
    @IBOutlet weak var recipe: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (success, error) in
            if let error = error {
                NSLog("Error uploading recipes: \(error)")
                return
            }
            self.allRecipes = success ?? []
            
        }
    }
    
    @IBAction func enterRecipe(_ sender: Any) {
        recipe.resignFirstResponder()
        filterRecipes()
    }
    
    @IBAction func searchChanged(_ sender: Any) {
        filterRecipes()
    }
    
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.recipe.text, !text.isEmpty {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.lowercased().contains(text) || recipe.instructions.lowercased().contains(text)
                })
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipe" {
            guard let recipesTVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipesTVC
        }
    }
    

}
