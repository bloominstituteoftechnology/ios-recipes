//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_259 on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    let recipeController = RecipeController.recipeController
    
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
    
    // MARK: - IBOutlets
    @IBOutlet var recipeTextField: UITextField!
    
    
    // MARK: - IBActions
    @IBAction func recipeTextFieldEdited(_ sender: Any) {
        recipeTextField.resignFirstResponder()
        filterRecipes()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "HasLoadedFromNetwork") {
            recipeController.loadFromPersistentStore()
            allRecipes = recipeController.recipes 
        } else {
            networkClient.fetchRecipes { (recipes, error) in
                if let allRecipes = recipes {
                    DispatchQueue.main.async {
                        self.allRecipes = allRecipes
                    }
                }
                
                if let error = error {
                    NSLog("Error fetching recipes data: \(error)")
                }
            }
            UserDefaults.standard.set(true, forKey: "HasLoadedFromNetwork")
            recipeController.saveToPersistentStore()
        }
        // Do any additional setup after loading the view.
    }
    
    func filterRecipes() {
        guard let filter = recipeTextField.text, !filter.isEmpty
            else {
                filteredRecipes = allRecipes
                return }
        filteredRecipes = allRecipes.filter { $0.name.contains(filter.capitalized) || $0.name.contains(filter.lowercased()) || $0.instructions.contains(filter.capitalized) || $0.instructions.contains(filter.lowercased()) }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            guard let recipeTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTableVC
            
        }
    }

}
