//
//  MainViewController.swift
//  Recipes
//
//  Created by Tobi Kuyoro on 13/01/2020.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            } else {
                
                guard let recipes = recipes else { return }
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    @IBAction func searchFieldEditingEnded(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    func filterRecipes() {
        guard let searchTerm = textField.text,
            !searchTerm.isEmpty else {
                filteredRecipes = allRecipes
                return
        }
        
        filteredRecipes = allRecipes.filter({ $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) })
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipesTableViewSegue" {
            if let destinationVC = segue.destination as? RecipesTableViewController {
                recipesTableViewController = destinationVC
            }
        }
    }
}
