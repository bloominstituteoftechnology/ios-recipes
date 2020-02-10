//
//  MainViewController.swift
//  Recipes
//
//  Created by scott harris on 2/10/20.
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
                NSLog("Error fething Recipes \(error)")
            }
            
            if let recipes = recipes {
                
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
                
            }
            
        }
        
    }
    
    func filterRecipes() {
        guard let text = textField.text, !text.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { $0.name.contains(text) || $0.instructions.contains(text) }
        
        
        
        
    }
        
    
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
        filterRecipes()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewEmbedSegue" {
            if let destinationVC = segue.destination as? RecipesTableViewController {
                recipesTableViewController = destinationVC
            }
        }
    }
}
