//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by scott harris on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        let recipe = recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetailSegue" {
            if let selectedIndex = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? RecipeDetailViewController {
                let recipe = recipes[selectedIndex.row]
                destinationVC.recipe = recipe
            }
        }
    }
    
    
}
