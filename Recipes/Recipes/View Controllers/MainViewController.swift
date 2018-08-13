//
//  MainViewController.swift
//  Recipes
//
//  Created by Lisa Sampson on 8/13/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (success, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            
            self.allRecipes = success ?? []
        }
    }
    
    @IBAction func filterRecipes(_ sender: Any) {
        textField.resignFirstResponder()
        filteringRecipes()
    }
    
    func filteringRecipes() {
        DispatchQueue.main.async {
            if let search = self.textField.text, search.count > 0 {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.contains(search) || recipe.instructions.contains(search)
                })
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableSegue" {
            guard let recipeTVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTVC
        }
    }

    @IBOutlet weak var textField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filteringRecipes()
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
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
}
