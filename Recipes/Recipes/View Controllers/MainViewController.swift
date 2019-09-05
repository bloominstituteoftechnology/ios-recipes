//
//  MainViewController.swift
//  Recipes
//
//  Created by Casualty on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var recipesTableViewController:
        RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    let networkClient = RecipesNetworkClient()
    var recipeList: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if allRecipes.count == 0 {
        networkClient.fetchRecipes{ (recipes, error) in
            if let error = error {
                NSLog("Error getting students: \(error)")
                return
            }
            self.recipeList = recipes ?? []
        }
    }
    
    func filterRecipes () {
        
        DispatchQueue.main.async {
            if let text = self.textField.text, text != "" {
                
                self.filteredRecipes = self.recipeList.filter{ recipe in recipe.name.contains(text) || recipe.instructions.contains(text)}
            }
            else {
                self.filteredRecipes = self.recipeList
            }
           
        }
    }
    
    @IBAction func sortUserString(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    @IBAction func textFieldshouldReturn(_ sender: Any) {
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.filteredRecipes = self.recipeList
        self.textField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RecipesViewSegue" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
}
