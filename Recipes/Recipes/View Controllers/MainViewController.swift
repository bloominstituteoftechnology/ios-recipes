//
//  MainViewController.swift
//  Recipes
//
//  Created by Jason Modisett on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("An error occured fetching recipes: \(error)")
            }
            
            guard let recipes = recipes else { return }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes
            }
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewController" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    @IBAction func editingDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        filterRecipes()
        return false
    }
    
    private func filterRecipes() {
        guard let searchTerm = textField.text else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
            recipe.name.contains(searchTerm) || recipe.instructions.contains(searchTerm)
        })
    }
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] { didSet {
        filterRecipes()
        }}
    
    var filteredRecipes: [Recipe] = [] { didSet {
        recipesTableViewController?.recipes = filteredRecipes
        }}
    
    var recipesTableViewController: RecipesTableViewController? { didSet {
        recipesTableViewController?.recipes = filteredRecipes
        }}
    
    @IBOutlet weak var textField: UITextField!
    
}
