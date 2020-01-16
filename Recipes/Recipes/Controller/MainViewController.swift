//
//  MainViewController.swift
//  Recipes
//
//  Created by Morgan Smith on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func tapRecipeSearch(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    @IBOutlet weak var recipeSearch: UITextField!
    
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
    
    func filterRecipes() {
        if recipeSearch.text == nil || recipeSearch.text == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = filteredRecipes.filter { (allRecipes) -> Bool in
                recipeSearch.text == allRecipes.name || recipeSearch.text == allRecipes.instructions
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
               guard error == nil else {
                   print("Error loading recipes: \(error!)")
                   return
               }
            
            guard let recipes = recipes
                else {return}
            self.allRecipes = recipes
                
        }

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "RecipeTableCell" {
          
          guard let destinationVC = segue.destination as? RecipesTableViewController else { return }
        
        self.recipesTableViewController = destinationVC
      }
    }
    

}
