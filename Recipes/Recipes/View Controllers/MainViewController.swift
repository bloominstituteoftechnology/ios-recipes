//
//  MainViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
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
    var allRecipes: [Recipe] = [] {
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
                self.allRecipes = recipes ?? []
        }
    }
    
    func filterRecipes () {
        
        DispatchQueue.main.async {
            if let text = self.textField.text, text != "" {
                
                self.filteredRecipes = self.allRecipes.filter{ recipe in recipe.instructions.contains(text)}
            }
            else {
                self.filteredRecipes = self.allRecipes
            }
            self.textField.text = nil
        }
    }
    
    @IBAction func sortUserString(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    @IBAction func textFieldshouldReturn(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedRecipesViewSegue" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
}
