//
//  MainViewController.swift
//  Recipes
//
//  Created by Joseph Rogers on 10/29/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var searchTextfield: UITextField!
    
    
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
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error Loading data \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    //MARK: Actions
    

    @IBAction func textFieldAction(_ sender: Any) {
        self.searchTextfield.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.searchTextfield.text, text != "" {
                self.filteredRecipes = self.allRecipes.filter( {(recipe) in recipe.name.contains(text) || recipe.instructions.contains(text)} )
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedChildSegue" {
            let vc = segue.destination as! RecipesTableViewController
                recipesTableViewController = vc
        }
    }
}
