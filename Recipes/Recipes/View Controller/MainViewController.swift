//
//  MainViewController.swift
//  Recipes
//
//  Created by Claudia Contreras on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var recipeSearchBar: UITextField!
    
    
    // MARK: - Properties
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (allRecipes, error) in
            guard error == nil else {
                print("Error loading recipes: \(error!)")
                return
            }
            
            guard let allRecipes = allRecipes else {
                print("Error loading recipes: The array was nil.")
                return
                
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func searching(_ sender: UITextField) {
        sender.resignFirstResponder()
        filterRecipes()
    }
    
    //MARK: - Functions
    func filterRecipes() {
        if let recipeSearch = recipeSearchBar.text,
        !recipeSearch.isEmpty {
            filteredRecipes = allRecipes.filter({$0.name.contains(recipeSearch) || $0.instructions.contains(recipeSearch)})
        } else {
            filteredRecipes = allRecipes
        }
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
              }
    }
}
