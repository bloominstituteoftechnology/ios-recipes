//
//  MainViewController.swift
//  Recipes
//
//  Created by Kobe McKee on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    let networkClient = RecipesNetworkClient()
    
    
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
    
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading recipes from file: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }

    
    func filterRecipes() {
        
        guard let searchTerm = searchTextField.text?.lowercased(), !searchTerm.isEmpty else {
            filteredRecipes = allRecipes
            return }
            let searchRecipes = allRecipes.filter ( { $0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm) } )
            filteredRecipes = searchRecipes
            //return
    }

    

    @IBAction func search(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeTableSegue" {
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
        }
    }

    
    
    
    
}
