//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Claudia Contreras on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetail" {
            if let detailViewController = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let recipe = recipes[indexPath.row]
                detailViewController.recipe = recipe
            }
        }
    }
    
    
}
