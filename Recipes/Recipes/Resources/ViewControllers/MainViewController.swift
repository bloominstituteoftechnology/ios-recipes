//
//  MainViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var networkClient = RecipesNetworkClient()
    
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
            
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }

    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes {  (allRecipes, error) in
            if let error = error {
                NSLog("Oops, \(error)")
                return
            }
            self.allRecipes = allRecipes ?? []
        }
    }
    
    
    @IBAction func searchComplete(_ sender: UITextField) {
        searchTextField.resignFirstResponder()
        filterRecipes()
        
    }
    
    func filterRecipes(){
        
        DispatchQueue.main.async {
        
        guard let userInput = self.searchTextField.text, !userInput.isEmpty else {
            self.filteredRecipes = self.allRecipes
            return
        }
        self.filteredRecipes = self.allRecipes.filter {
            ($0.name.contains(userInput) ) || ($0.instructions.contains(userInput))
            
        }
        }
        
    }

    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "embedTableViewSegue" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = recipesTableVC
            
        }
        
    }
    
    
}
