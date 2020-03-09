//
//  MainViewController.swift
//  Recipes
//
//  Created by Nichole Davidson on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            
            if let recipes = recipes {
                DispatchQueue.main.async {
                self.allRecipes = recipes
                }
            }
        }
    }
    
    func filterRecipes(completion: @escaping([Recipe]) -> Void) {
        var updatedRecipes: [Recipe]
        let searchString = searchTextField.text
        
        guard case searchTextField.text = searchTextField.text else {
            if searchString != nil {
            filteredRecipes = allRecipes
            } else {
                updatedRecipes = allRecipes.filter { $0.name == "\(searchString ?? "")" }
                updatedRecipes = allRecipes.filter { $0.instructions == "\(searchString ?? "")" }
        }
            
            return
        }
        
        self.filteredRecipes = updatedRecipes
}
    

    @IBAction func searchTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            guard let viewRecipeVC = segue.destination as? RecipesTableViewController else { return }
            
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    }
}
