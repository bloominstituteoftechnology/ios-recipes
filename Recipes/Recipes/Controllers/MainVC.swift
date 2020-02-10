//
//  MainViewController.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainVC: UIViewController
{
    private let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
           filterRecipes()
        }
    }
    
    var filteredRecipes : [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var recipesTableViewController : RecipesTableVC? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstSegue" {
            // TODO
            let destination = segue.destination
            if let recipesTableVC = destination as? RecipesTableVC {
                recipesTableViewController = recipesTableVC
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading recipes:\(error)")
                return
            }
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
       
    }
    
    
    @IBOutlet weak var textField: UITextField!
  
    @IBAction func textFieldChanged(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let searchTerm = textField.text else { return }
         
              if searchTerm == "" {
                  filteredRecipes = allRecipes
              } else {
                let nameFilter = allRecipes.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
                let instructionFiler = allRecipes.filter { $0.instructions.contains(searchTerm.lowercased())}
                 filteredRecipes = nameFilter + instructionFiler
              }
          }
      
}
