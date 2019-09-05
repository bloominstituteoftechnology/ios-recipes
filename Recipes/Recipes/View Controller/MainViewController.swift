//
//  MainViewController.swift
//  Recipes
//
//  Created by John Kouris on 9/3/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if error != nil {
                NSLog("Error fetching recipes")
                return
            } else {
                guard let recipes = recipes else { return }
                self.allRecipes = recipes
            }
        }
    }
    
    @IBAction func searchTextFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededTableView" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    // MARK: - Private methods
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchText = self.searchTextField.text else { return }
            if searchText.isEmpty || searchText == "" {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains(searchText) }
            }
        }
    }

}
