//
//  MainViewController.swift
//  Recipes
//
//  Created by Diante Lewis-Jolley on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipeTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }

    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.textField.text, !text.isEmpty {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.lowercased().contains(text) || recipe.instructions.lowercased().contains(text)})
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }

        override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (success, error) in
            if let error = error {
                NSLog("Error uploading recipes: \(error)")
                return
            }
            self.allRecipes = success ?? []
        }
}
    
    @IBAction func textFieldbutton(_ sender: Any) {
        filterRecipes()
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "CellSegue" {
            guard let recipesTVC = segue.destination as? RecipeTableViewController else { return }
            recipesTableViewController = recipesTVC
        }
    }
}



