//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_201 on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    let networkClient = RecipesNetworkClient()
    private var allRecipes: [Recipe] = [] {
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
    
    
    
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBAction func EditingDidEndOnExit(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipe, error) in
            if let error = error {
                NSLog("Error fetching recipes. \(error)")
                return
            }
            
            if let recipe = recipe {
                DispatchQueue.main.async {
                    self.allRecipes = recipe
                    print("\(self.allRecipes)")
                }
            }
        }
    }
    
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let textField = self.textFieldOutlet.text, !textField.isEmpty else {return self.filteredRecipes = self.allRecipes}
            
            self.filteredRecipes = self.allRecipes.filter({$0.name.contains(textField) || $0.instructions.contains(textField)
                
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailsSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
}
