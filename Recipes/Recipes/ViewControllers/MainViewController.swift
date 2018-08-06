//
//  MainViewController.swift
//  Recipes
//
//  Created by Jonathan T. Miles on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
            }
            guard let recipe = recipes else { return }
            self.allRecipes = recipe
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        searchRecipeTextField.resignFirstResponder()
        filterRecipes()
    }
    
    
    // Custom functions
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let enteredText = self.searchRecipeTextField.text else { return }
            if enteredText == "" {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains(enteredText) || $0.instructions.contains(enteredText) }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeTableViewSegue" {
            let destVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destVC
        }
    }
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
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
    
    @IBOutlet weak var searchRecipeTextField: UITextField!
    
}
