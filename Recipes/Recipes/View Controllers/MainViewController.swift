//
//  MainViewController.swift
//  Recipes
//
//  Created by Mark Gerrior on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func textFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Properties
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
    let networkClient = RecipesNetworkClient()
        
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading recipes: \(error)!")
                return
            }
            if let recipes = recipes {
                DispatchQueue.main.sync {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    func filterRecipes() {
        if let searchString = textField.text,
            !searchString.isEmpty
        {
            filteredRecipes = allRecipes.filter {
                $0.name.contains(searchString) ||
                $0.instructions.contains(searchString)
            }
        } else {
            // Nothing to search for
            filteredRecipes = allRecipes
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "RecipesSegue" {
            print("RecipesSegue called")
            guard let recipesTVC = segue.destination as? RecipesTableViewController else { fatalError() }
            recipesTableViewController = recipesTVC
        }
    }
}
