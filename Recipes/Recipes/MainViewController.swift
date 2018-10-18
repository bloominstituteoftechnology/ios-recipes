//
//  MainViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
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
    
    
    @IBOutlet weak var searchTextField: UITextField!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipesFetched, error) in
            if let error = error {
                NSLog("Error getting the recipes!...\(error)")
            }
            self.allRecipes = recipesFetched ?? []
        }

    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        self.resignFirstResponder()
        filterRecipes()
    }
    func filterRecipes(){
        
        guard let searchTerm = searchTextField.text, !searchTerm.isEmpty else {
            self.filteredRecipes = self.allRecipes
            return
        }
        // Filter for the search word
        let namesMatch = self.allRecipes.filter { $0.name.range(of: searchTerm, options: .caseInsensitive) != nil }
        
        let instructionsMatch = self.allRecipes.filter { $0.instructions.range(of: searchTerm, options: .caseInsensitive) != nil }

        filteredRecipes = namesMatch + instructionsMatch
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedTableViewSegue" {
           let destinationVC = segue.destination as? RecipesTableViewController
            recipesTableViewController = destinationVC
        }
    }
   

}
