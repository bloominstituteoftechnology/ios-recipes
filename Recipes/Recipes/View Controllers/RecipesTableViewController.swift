//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by De MicheliStefano on 06.08.18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController, RecipeDetailViewControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    func updateRecipes(recipe: Recipe, instructions: String) {
        guard let networkClient = networkClient else { return }
        networkClient.updateRecipes(for: recipe, instructions: instructions)
        if let recipes = networkClient.loadFromPersistence() {
            self.recipes = recipes
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetail" {
            guard let detailVC = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.recipe = recipes[indexPath.row]
            detailVC.networkClient = networkClient
            detailVC.delegate = self
        }
    }

    // MARK: - Properties
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var networkClient: RecipesNetworkClient?
    
}
