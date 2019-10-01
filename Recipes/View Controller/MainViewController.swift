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
            
            // Question: How come filteredRecipes didn't autocomplete? Probably a bug.
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
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
        
        // TODO: What does "if there is no search term" mean?
        guard let searchText = searchTextField.text
            else {
                filteredRecipes = allRecipes
                return
        }
        
        // TODO: Not sure if correct
        filteredRecipes = allRecipes.filter({ $0.name == searchText || $0.instructions == searchText })
    }
    
    
    @IBAction func textFieldAction(_ sender: Any) {
        
        // TODO: Not sure if correct. Is it resignFirstResponder() or searchTextField.resignFirstResponder()?
        searchTextField.resignFirstResponder()
        filterRecipes()
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
