//
//  MainViewController.swift
//  Recipes
//
//  Created by Conner on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("\(error)")
                return
            } else {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        filterRecipes()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let searchTerm = self.textField.text {
                if searchTerm.count == 0 {
                    self.filteredRecipes = self.allRecipes
                } else {
                    self.filteredRecipes = self.allRecipes.filter({ $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) })
                }
            }
        }

    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RecipesEmbedSegue") {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }

}
