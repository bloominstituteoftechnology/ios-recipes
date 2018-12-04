//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Madison Waters on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    let reuseIdentifier = "RecipeCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }
    
    // MARK: - Navigation

    // recipeTableView // recipeDetailView //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipeDetailVC = segue.destination as! RecipeDetailViewController
            
            let selectedRecipe = recipes[indexPath.row]
            recipeDetailVC.recipe = selectedRecipe
        }
    }
    
    var recipes: [Recipe] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
