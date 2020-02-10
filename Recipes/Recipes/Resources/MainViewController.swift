//
//  MainViewController.swift
//  Recipes
//
//  Created by Keri Levesque on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: Properties
    //create constant called network client
    let networkClient = RecipesNetworkClient()
    // create variable allRecipes
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
        DispatchQueue.main.async {
            guard let recipeTextField = self.recipeTextField.text,
                !recipeTextField.isEmpty else { return self.filteredRecipes = self.allRecipes}
            self.filteredRecipes = self.allRecipes.filter({
                $0.name.contains(recipeTextField) || $0.instructions.contains(recipeTextField)
            })
        }
    }
    // MARK: Outlets
   @IBOutlet weak var recipeTextField: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion:  { recipes, error in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        })
    }
    


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    // MARK: Actions
    @IBAction func searchTextField(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
     
}
