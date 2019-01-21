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
        guard let searchText = searchTextField.text else {return}
        
        if !searchText.isEmpty {
            let filteredRecipes = allRecipes.filter { (recipe) -> Bool in contains(searchText as! UIFocusEnvironment) }
        } else {
            filteredRecipes = allRecipes
        }
        recipesTableViewController!.recipes = filteredRecipes
        
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedRecipes" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    

}
