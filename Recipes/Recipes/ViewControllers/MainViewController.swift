//
//  MainViewController.swift
//  Recipes
//
//  Created by Thomas Cacciatore on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []

            }
        

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            let recipesTVC = segue.destination as? RecipesTableViewController
            recipesTableViewController = recipesTVC
        }
    }
    // NOT WORKING
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.mainTextField.text else { return }
        if searchTerm.isEmpty == true {
            self.filteredRecipes = self.allRecipes
        }  else {
            self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm) }
        }
        }
    }
    @IBAction func mainTextFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    
    
    @IBOutlet weak var mainTextField: UITextField!
    
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
    
    let networkClient = RecipesNetworkClient()
}
