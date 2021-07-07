//
//  MainViewController.swift
//  Recipes
//
//  Created by Aaron Cleveland on 1/12/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipe()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.searchRecipes = self.filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.searchRecipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error is \(error)")
                return
            }
            
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    @IBAction func textFieldTapped(_ sender: Any) {
        resignFirstResponder()
        filterRecipe()
    }
    
    func filterRecipe() {
        guard let unwrapSearch = textField.text, !unwrapSearch.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter {
            $0.name.uppercased().contains(unwrapSearch.uppercased()) || $0.instructions.uppercased().contains(unwrapSearch.uppercased())
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTableSegue" {
            guard let showTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = showTableVC
        }
    }

}
