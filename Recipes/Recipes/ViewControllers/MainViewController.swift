//
//  MainViewController.swift
//  Recipes
//
//  Created by Thomas Cacciatore on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            self.allRecipes = recipes!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            let recipesTVC = segue.destination as? RecipesTableViewController
        }
    }
    
    func filterRecipes() {
        guard let searchTerm = mainTextField.text else { return }
        if searchTerm.isEmpty == true  {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.name == searchTerm || $0.instructions == searchTerm }
            
        }
        
    }

    @IBAction func mainTextFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    
    
    @IBOutlet weak var mainTextField: UITextField!
    
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    let networkClient = RecipesNetworkClient()
}
