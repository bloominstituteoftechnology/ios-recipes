//
//  MainViewController.swift
//  Recipes
//
//  Created by Nikita Thomas on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func finishedEditingText(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    
    
    var recipeTableViewController: RecipeTableViewController? {
        didSet {
            recipeTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes = [Recipe]() {
        didSet {
            recipeTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipes, error in
            if error != nil {
                NSLog("error: \(error!)")
                return
            } else {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    func filterRecipes() {
        guard let text = textField.text else {return}
        if text.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter({ $0.name.contains(text) || $0.instructions.contains(text) })
        }
    }
    
    
     // MARK: - Navigation
     

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        guard let destination = segue.destination as? RecipeTableViewController else {return}
        if segue.identifier == "toTableView" {
            destination.recipes = allRecipes
        }
        
     }

    
}
