//
//  MainViewController.swift
//  Recipes
//
//  Created by Chad Parker on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!

    let networkClient = RecipesNetworkClient()
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
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { recipes, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let recipes = recipes else { return }

            DispatchQueue.main.async {
                self.allRecipes = recipes
            }
        }
    }


    
    @IBAction func searchTextFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }

    private func filterRecipes() {
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            filteredRecipes = allRecipes
            return
        }

        filteredRecipes = allRecipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.instructions.localizedCaseInsensitiveContains(searchText) }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSegue" {
            guard let recipesTVC = segue.destination as? RecipesTableViewController else { return }

            recipesTableViewController = recipesTVC
        }
    }
}
