//
//  MainViewController.swift
//  Recipes
//
//  Created by morse on 10/27/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    struct PropertyKeys {
        static let embedSegue = "TableViewEmbedSegue"
    }
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
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
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipe array: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                    self.recipesTableViewController?.reloadInputViews()
                }
            }
        }
    }
    
    @IBAction func editingEnded(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    
    func filterRecipes() {
        guard let searchTerm = textField.text, !searchTerm.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter({ $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)
        })
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.embedSegue {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
