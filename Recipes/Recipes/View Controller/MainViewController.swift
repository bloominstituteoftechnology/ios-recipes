//
//  MainViewController.swift
//  Recipes
//
//  Created by Eoin Lavery on 15/01/2020.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - Properties
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
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                print("Error when attempting to fetch recipes")
                return
            }
            
            guard let recipes = recipes else {
                print("Error: Unable to load recipes")
                return
            }
            
            self.allRecipes = recipes
        }
    }
    
    //MARK: - Private Functions
    private func filterRecipes() {
        guard let searchText = textField.text,
            searchText != nil else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText) || $0.instructions.lowercased().contains(searchText)}
    }
    
    //MARK: - IBActions
    @IBAction func editingDidEnd(_ sender: Any) {
        resignFirstResponder()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
