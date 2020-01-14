//
//  MainViewController.swift
//  Recipes
//
//  Created by Jorge Alvarez on 1/13/20.
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
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                    print(self.allRecipes)
                }
            }
        }
    }
    
    func filterRecipes() {
        guard let term = textField.text, !term.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
         
    filteredRecipes = allRecipes.filter {
        $0.name.uppercased().contains(term.uppercased())
        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            guard let recipesTVC = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = recipesTVC
            print("segue to TVC")
        }
    }
}
