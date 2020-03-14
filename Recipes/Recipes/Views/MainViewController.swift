//
//  MainViewController.swift
//  Recipes
//
//  Created by Breena Greek on 3/13/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet { filterRecipes() }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet { self.recipesTableViewController?.recipes = filteredRecipes }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet { recipesTableViewController?.recipes = self.filteredRecipes }
    }

    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func searchTextFieldAction(_ sender: Any) {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("Error loading recipes: \(error!)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
            print(self.allRecipes)
        }
    }
    
    func filterRecipes() {
        if let recipeSearch = searchTextField.text, !recipeSearch.isEmpty {
            filteredRecipes = allRecipes.filter {$0.name.contains(recipeSearch)}
        } else {
            filteredRecipes = allRecipes
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
