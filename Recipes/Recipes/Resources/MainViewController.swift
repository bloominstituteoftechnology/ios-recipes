//
//  MainViewController.swift
//  Recipes
//
//  Created by Jocelyn Stuart on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            
            self.allRecipes = recipes ?? []
            
        }
        
    }
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBAction func searchEdited(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController!.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController!.recipes = filteredRecipes
        }
    }
    
    
  
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchText = self.searchTextField.text else {return}
            
            if !searchText.isEmpty {
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText) } //(recipe) -> Bool in self.contains(searchText as! UIFocusEnvironment)
                
            } else {
                self.filteredRecipes = self.allRecipes
            }
            self.recipesTableViewController!.recipes = self.filteredRecipes
        }
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedRecipes" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    

}
