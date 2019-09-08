//
//  MainViewController.swift
//  Recipes
//
//  Created by Jessie Ann Griffin on 9/3/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: IBOutlets    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: Properties
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    // MARK: Processing - Filtering and sorting
    func filterRecipes() {
        guard let searchItem = searchTextField.text, !searchItem.isEmpty else { return }
        if searchItem.isEmpty {
            filteredRecipes = allRecipes
        } else {
            let result = recipesTableViewController?.recipes.filter { $0.name.contains(searchItem) || $0.instructions.contains(searchItem)}
            guard let results = result else { return }
            filteredRecipes = results
        }
    }
    
    // MARK: Actions
    @IBAction func searchTextEntered(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededTableViewSegue" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipesTableVC
        }
    }
}
