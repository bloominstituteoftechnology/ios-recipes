//
//  MainViewController.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainVC: UIViewController , UISearchBarDelegate
{
    private let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filteredRecipes = allRecipes
        }
    }
    
    
    var filteredRecipes = [Recipe]() {
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredRecipes = allRecipes
        } else {
            for recipe in allRecipes {
                if recipe.name.contains(searchText) {
                    let nameFilter = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                    filteredRecipes = nameFilter
                } else if recipe.instructions.contains(searchText) {
                    let instructionFiler = allRecipes.filter { $0.instructions.contains(searchText.lowercased())}
                    filteredRecipes = instructionFiler
                }
            }
//            filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.instructions.lowercased().contains(searchText.lowercased())}
            
        }
        
        
    }
    

      
}
