//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by morse on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    var recipes: [Recipe] = [] {
        didSet {
            print("Recipes set: \(recipes.count)")
            tableView.reloadData()
        }
    }
//    var recipeIndexPath: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("#OfRows: \(recipes.count)")
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTitleCell", for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            
            guard let recipesDetailVC = segue.destination as? RecipeDetailViewController else { return }
            guard let recipeIndexPath = tableView.indexPathForSelectedRow else { return }
            recipesDetailVC.recipe = recipes[recipeIndexPath.row]
        }
    }
}
