//
//  MainViewController.swift
//  Recipes
//
//  Created by Joshua Rutkowski on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - Properties
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    func filterRecipes() {
         DispatchQueue.main.async {
             guard let textField = self.textField.text,
                 !textField.isEmpty else { return self.filteredRecipes = self.allRecipes }

             self.filteredRecipes = self.allRecipes.filter({
                 $0.name.contains(textField) || $0.instructions.contains(textField)
             })
         }
     }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion: { recipes, error in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        })

    }
    
    

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "TableSegue" {
                 recipesTableViewController = segue.destination as? RecipesTableViewController
             }
         }



    //MARK: - IBActions
    @IBAction func textFieldEditDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
}
