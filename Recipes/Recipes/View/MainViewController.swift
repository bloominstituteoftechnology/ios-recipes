//
//  MainViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
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
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
            }
            
            self.allRecipes = recipes ?? []
        }
    }
    
    // MARK: - UI Methods
    @IBAction func searchRecipes(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipeTableView" {
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
        }
    }
    
    // MARK: - Private Utility Functions
    private func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.searchTextField.text, !searchTerm.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            
            let namesMatch = self.allRecipes.filter { $0.name.range(of: searchTerm, options: .caseInsensitive) != nil }
            let instructionsMatch = self.allRecipes.filter { $0.instructions.range(of: searchTerm, options: .caseInsensitive) != nil && namesMatch.index(of: $0) == nil }
            
            self.filteredRecipes = namesMatch + instructionsMatch
        }
    }

}
