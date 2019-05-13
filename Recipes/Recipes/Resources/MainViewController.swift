//
//  MainViewController.swift
//  Recipes
//
//  Created by Jonathan Ferrer on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    var networkClient = RecipesNetworkClient()
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
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes from server: \(error)")
                return
            } else {
                guard let recipes = recipes else { return }
                self.allRecipes = recipes
            }
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableView" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }

    func filterRecipes() {
        DispatchQueue.main.async {

            guard let searchTextFieldText = self.searchTextField.text, !searchTextFieldText.isEmpty else  {
            self.filteredRecipes = self.allRecipes
            return


        }
            self.filteredRecipes = self.allRecipes.filter { ($0.name.contains(searchTextFieldText) || $0.instructions.contains(searchTextFieldText))}
    }
    }
    @IBAction func search(_ sender: UITextField) {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }

    
}
