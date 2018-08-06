//
//  MainViewController.swift
//  Recipes
//
//  Created by Linh Bouniol on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
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
    
    // MARK: - Outlets
    
    @IBOutlet var searchTextField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func search(_ sender: Any) {
        // Tells the textField to stop accepting keyboard input
        searchTextField.resignFirstResponder()
        
        filterRecipes()
    }
    
    // MARK: - Methods
    
    func filterRecipes() {
        
        if let searchTerm = searchTextField.text, searchTerm.count > 0 {
            filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
                return recipe.name.contains(searchTerm) || recipe.instructions.contains(searchTerm)
            })
//            filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
        } else {
            // Display all recipes
            filteredRecipes = allRecipes
        }
    }
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error geting recipes: \(error)")
                return
            }
            
            // If there is no error, get the recipes
            self.allRecipes = allRecipes ?? []
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    

}
