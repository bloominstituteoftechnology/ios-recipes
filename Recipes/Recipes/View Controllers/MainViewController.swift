//
//  MainViewController.swift
//  Recipes
//
//  Created by Niranjan Kumar on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
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
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes(completion: {recipes, error in
            if let error = error {
                print("Error loading recipes: \(error)")
            }
            
            DispatchQueue.main.sync {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
            
        })
        
    }
    
    // MARK: - Methods
    
    @IBAction func editTextField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    private func filterRecipes() {
        guard let search = searchTextField.text, !search.isEmpty else { return filteredRecipes = allRecipes }
      
        // If there is a non-empty search term in the text field, using the filter higher-order function to filter the allRecipes array. It should filter by checking if the recipe's name or instructions contains the search term. Set the value of the filteredRecipes to the result of the filter method.
        
        filteredRecipes = allRecipes.filter {$0.name.localizedCaseInsensitiveContains(search) || $0.instructions.localizedCaseInsensitiveContains(search)}
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSegue" {
            guard let recipeTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTableVC
        
        }
    }

}
 
