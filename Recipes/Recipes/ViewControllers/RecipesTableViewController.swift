//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Thomas Cacciatore on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let detailVC = segue.destination as? RecipeDetailViewController
            detailVC?.recipe = sender as? Recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.name

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recipe = recipes[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: recipe)
    }

    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
}
