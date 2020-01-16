//
//  MainViewController.swift
//  Recipes
//
//  Created by Sal Amer on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    // IB Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
           guard error == nil else {
                print("Error Loading Recipes: \(error)")
                return
            }
            guard let recipes = recipes else {
                print("Error Unable tp Load Recipes")
                return
            }
            self.allRecipes = recipes
        }
//        searchTextField.delegate = self
    }
    
    // Private Function
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    func filterRecipes() {
        guard let searchBarText = searchTextField.text,
            searchBarText != "" else {
                filteredRecipes = allRecipes
                return
        }
        filteredRecipes = allRecipes.filter { $0.name.contains(searchBarText) || $0.instructions.contains(searchBarText)}
//        filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchBarText.lowercased()) || $0.instructions.lowercased().contains(searchBarText.lowercased())}
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipesSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    
    // IB Action
    @IBAction func searchBarEnded(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
}
