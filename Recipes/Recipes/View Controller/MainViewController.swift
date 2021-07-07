//
//  MainViewController.swift
//  Recipes
//
//  Created by Ilgar Ilyasov on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes = [Recipe]() {
        didSet { filterRecipes() }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet { recipesTableViewController?.recipes = filteredRecipes }
    }
    
    var filteredRecipes = [Recipe]() {
        didSet { recipesTableViewController?.recipes = filteredRecipes }
    }
    
    @IBOutlet weak var recipeTextField: UITextField!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    @IBAction func recipeTextFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let searchTerm = recipeTextField.text else { return }
        
        if searchTerm == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter{ $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
}
