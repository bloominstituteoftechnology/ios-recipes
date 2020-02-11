//
//  MainViewController.swift
//  Recipes
//
//  Created by Enrique Gongora on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Variables
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
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    let networkClient = RecipesNetworkClient()
    
    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBAction func searchTextField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipe, error) in
            if let error = error {
                NSLog("Error loading recipes \(error)")
                return
            }
            DispatchQueue.main.async {
                guard let recipe = recipe else { return }
                self.allRecipes = recipe
            }
        }
    }
    
    func filterRecipes() {
        guard let searchText = textField.text, !searchText.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue"{
            guard let recipeVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeVC
        }
    }
    
}
