//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Iyin Raphael on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        let newRecipe = recipe[indexPath.row]
        cell.textLabel?.text = newRecipe.name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe"{
            guard let detailVC = segue.destination as? RecipeDetailViewController,
                let index = tableView.indexPathForSelectedRow else {return}
            detailVC.recipe = recipe[index.row]
        }
    }
    var recipe = [Recipe](){
        didSet{
            tableView.reloadData()
        }
    }
}
