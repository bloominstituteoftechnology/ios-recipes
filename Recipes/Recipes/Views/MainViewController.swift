//
//  MainViewController.swift
//  Recipes
//
//  Created by Breena Greek on 3/13/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allrecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []

    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func searchTextFieldAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("Error loading recipes: \(error!)")
                return
            }
            
            guard let recipes = recipes else {
                print("Error loading recipes: The recipes array was nil")
                return
            }
            
            self.allrecipes = recipes
        }
    }
    
    func filterRecipes() {
        if searchTextField.text!.isEmpty {
            return allrecipes
        } else {
            let filter = allrecipes ?? .name
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededSegue" {
            let recipeVC = segue.destination as?  else { return }
        }
    }
}
