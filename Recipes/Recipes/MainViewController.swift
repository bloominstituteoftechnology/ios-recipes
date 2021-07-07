//
//  MainViewController.swift
//  Recipes
//
//  Created by Gerardo Hernandez on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
      @IBOutlet weak var textField: UITextField!
      
    
      override func viewDidLoad() {
          super.viewDidLoad()
          networkClient.fetchRecipes { (allRecipes, error) in
              
              guard error == nil else {
                  print("Error loading recipes: \(error!)")
                  return
              }
              
              guard let allRecipes = allRecipes else {
                  print("Error allRecipes was nil!")
                  return
              }
              DispatchQueue.main.async {
                  self.allRecipes = allRecipes
              }
          }

      }
    // MARK: - Properties
    
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
  
    // MARK: - IBAction
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Functions
    
    func filterRecipes() {
        guard let userSearch = textField.text,
            userSearch != "" else {
                filteredRecipes = allRecipes
                return
        }
        filteredRecipes = allRecipes.filter {
            $0.name.contains(userSearch) || $0.instructions.contains(userSearch)
        }
    }
  
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "EmbededSegue",
        let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
        
        self.recipesTableViewController = recipesTableVC
     
    }
}
