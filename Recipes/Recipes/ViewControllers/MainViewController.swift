//
//  MainViewController.swift
//  Recipes
//
//  Created by John Pitts on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in   // this is a concurrent call to network
            
            if let error = error {
                NSLog("Error loading students: \(error)")
                return
            } else {
                
                DispatchQueue.main.async {
                guard let recipes = recipes else {return}
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    @IBAction func searchTextFieldExitted(_ sender: Any) {
        
        resignFirstResponder()
        filterRecipes()

    }
    
    func filterRecipes() {
        guard let searchTerm = searchTextField.text?.lowercased() else {return}
        if searchTerm == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm) }
            
        }
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerToTVC" {
            
            guard let recipesTVC = segue.destination as? RecipesTableViewController else { return }
            
            recipesTableViewController = recipesTVC
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    
    @IBOutlet var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    // i was told to make filteredRecipes = [] or i did that on my own?
    
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
    
}
