//
//  MainViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    let recipeController = RecipeController()

    var filteredRecipes: [Recipe] = [] {
        didSet {
            updateRecipeTV()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            updateRecipeTV()
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the search text field's delegate to the view controller
        searchTextField.delegate = self
        
        // Check if the user has previously loaded the recipes over the network
        let hasPreviouslyLoadedRecipes = UserDefaults.standard.bool(forKey: "HasLoadedRecipesFromNetwork")
        
        // If not, load them
        if !hasPreviouslyLoadedRecipes {
            networkClient.fetchRecipes { (recipes, error) in
                if let error = error {
                    NSLog("Error fetching recipes: \(error)")
                }
                
                guard let recipes = recipes else { return }
                for recipe in recipes {
                    self.recipeController.createRecipe(name: recipe.name, instructions: recipe.instructions)
                }
                
                UserDefaults.standard.set(true, forKey: "HasLoadedRecipesFromNetwork")
                self.filterRecipes()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filterRecipes()
    }
    
    // MARK: - UI Methods
    @IBAction func searchRecipes(_ sender: Any) {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - UI Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        filterRecipes()
        return true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipeTableView" {
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
        }
    }
    
    // MARK: - Private Utility Methods
    private func filterRecipes() {
        DispatchQueue.main.async {
            // Make sure there is a search term, otherwise set the filtered recipes to all the recipes
            guard let searchTerm = self.searchTextField.text, !searchTerm.isEmpty else {
                self.filteredRecipes = self.recipeController.recipes
                return
            }
            
            // Get the recipes who's names match
            let namesMatch = self.recipeController.recipes.filter { $0.name.range(of: searchTerm, options: .caseInsensitive) != nil }
            // Get the recipes who's instructions match and aren't in the first group
            let instructionsMatch = self.recipeController.recipes.filter { $0.instructions.range(of: searchTerm, options: .caseInsensitive) != nil && namesMatch.index(of: $0) == nil }
            
            // Add them together and put them in the filtered array
            self.filteredRecipes = namesMatch + instructionsMatch
        }
    }
    
    private func updateRecipeTV() {
        recipesTableViewController?.recipes = filteredRecipes
        recipesTableViewController?.recipeController = recipeController
    }

}
