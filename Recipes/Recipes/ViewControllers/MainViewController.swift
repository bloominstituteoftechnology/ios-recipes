//
//  MainViewController.swift
//  Recipes
//
//  Created by Thomas Cacciatore on 5/20/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading fetched recipes: \(error)")
                return
            }
            guard let recipes = recipes else { return }
            self.allRecipes = recipes
        }
    }
    
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.mainTextField.text else { return }
            if searchTerm == "" || searchTerm.isEmpty == true {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter( {$0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }

    @IBAction func searchTextField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }

    // Mark: - Properties
    
    let networkClient = RecipesNetworkClient()
    
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
    
    @IBOutlet weak var mainTextField: UITextField!
    
    
}
