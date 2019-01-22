//
//  MainViewController.swift
//  Recipes
//
//  Created by Moses Robinson on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("error getting recipes: \(error)")
                return
            } else {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    @IBAction func searchRecipe(_ sender: Any) {
        
    }
    
    private func filterRecipes() {
        guard let searchTerm = searchRecipesField.text?.lowercased(),
            !searchTerm.isEmpty else { return }
        
        if searchTerm.isEmpty {
            filteredRecipes = allRecipes
        } else {
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            
            recipesTableViewController = recipesTableVC
        }
    }
    
    //MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
    var recipesTableViewController: RecipesTableViewController?
    
    var filteredRecipes: [Recipe] = []
    
    @IBOutlet weak var searchRecipesField: UITextField!
    
}
