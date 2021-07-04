//
//  MainViewController.swift
//  Recipes
//
//  Created by Madison Waters on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var recipeTextField: UITextField!
    
    @IBAction func updateTextField(_ sender: Any) {
        recipeTextField.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            } else {
                DispatchQueue.main.async { self.allRecipes = recipes ?? [] }
            }
        }
    }
    
    func filterRecipes() {
        
        guard let searchTerm = recipeTextField.text,
            !searchTerm.isEmpty else {
                filteredRecipes = allRecipes
                return }
        
            filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
            recipesTableViewController?.recipes = filteredRecipes
            
        }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeTableView" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
            
        }
    }

    
    var allRecipes: [Recipe] = [] {
        didSet{ filterRecipes() }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet{ recipesTableViewController?.recipes = filteredRecipes }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet{ recipesTableViewController?.recipes = filteredRecipes }
    }
    
    let networkClient = RecipesNetworkClient()
    
}
