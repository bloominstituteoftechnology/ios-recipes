//
//  MainViewController.swift
//  Recipes
//
//  Created by Dennis Rudolph on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties:
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Methods:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion:{ recipes, error in
            if let error = error {
                print("Error loading recipes: \(error)")
            }
            
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        })
    }
    
    func filterRecipes() {
        if let text = textField.text, !text.isEmpty {
            filteredRecipes = allRecipes.filter { $0.name.localizedCaseInsensitiveContains(text) || $0.instructions.localizedCaseInsensitiveContains(text)}
        } else {
            filteredRecipes = allRecipes
        }
    }
    
    @IBAction func searched(sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
