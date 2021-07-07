//
//  MainViewController.swift
//  Recipes
//
//  Created by Nikita Thomas on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func finishedEditingText(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    @IBAction func filterTextChange(_ sender: Any) {
        filterRecipes()
    }
    
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    
    
    var recipeTableViewController: RecipeTableViewController! {
        didSet {
            recipeTableViewController.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes = [Recipe]() {
        didSet {
            recipeTableViewController.recipes = filteredRecipes
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipes, error in
            if error != nil {
                NSLog("error: \(error!)")
                return
            } else {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
        
    }
    
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.textField.text?.lowercased(), !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            self.filteredRecipes = self.allRecipes.filter({ $0.name.contains(text) || $0.instructions.contains(text) })
        }
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipeTableViewController else {return}
        if segue.identifier == "toTableView" {
            // destination.recipes = allRecipes
            recipeTableViewController = destination
        }
    }
}
