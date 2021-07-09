//
//  MainViewController.swift
//  Recipes
//
//  Created by Jeffrey Carpenter on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    private var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            
            if let error = error {
                NSLog("Error fetching recipes from server: \(error.localizedDescription)")
                return
            }
            
            guard let recipes = recipes else { return }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes
            }
        }
    }
    
    private func filterRecipes() {
        
        guard let filterBy = searchTextField.text?.lowercased(),
        !filterBy.isEmpty
        else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(filterBy) || $0.instructions.lowercased().contains(filterBy) }
    }
    
    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedRecipesTableView" {
            
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
