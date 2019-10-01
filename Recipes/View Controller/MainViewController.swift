//
//  MainViewController.swift
//  Recipes
//
//  Created by Andrew Ruiz on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
    var recipesTableViewController: RecipesTableViewController?
    
    var filteredRecipes: [Recipe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            } else {
                guard let allRecipes = allRecipes else { return }
                DispatchQueue.main.async {
                    self.allRecipes = allRecipes
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func filterRecipes() {
        
        // What does "if there is no search term" mean?
        guard let searchText = searchTextField.text
            else {
                filteredRecipes = allRecipes
                return
        }
        
        // If there is a non-empty search term in the text field, using the filter higher-order function to filter the allRecipes array. It should filter by checking if the recipe's name or instructions contains the search term. Set the value of the filteredRecipes to the result of the filter method.
        
        filteredRecipes = allRecipes.filter({ $0.name == searchText || $0.instructions == searchText })
    }
    
    
    @IBAction func textFieldAction(_ sender: Any) {
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTable" {
            guard let tableVC = segue.destination as? RecipesTableViewController else { return }
            
            recipesTableViewController = tableVC
        }
    }
    
}
