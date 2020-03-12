//
//  MainViewController.swift
//  Recipes
//
//  Created by Matthew Martindale on 3/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
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
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipe, error) in
            if error != nil {
                NSLog("There was an error fetching recipes")
                return
            }
            guard let recipe = recipe else { return }
            self.allRecipes = recipe
        }
    }
    
    @IBAction func searchDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTextField = self.searchTextField.text?.lowercased(),
                !searchTextField.isEmpty else { return self.filteredRecipes = self.allRecipes }
            self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().contains(searchTextField)
                || $0.instructions.lowercased().contains(searchTextField)
            }
        }
    }
    
}
