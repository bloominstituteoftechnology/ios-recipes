//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Waseem Idelbi on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    //MARK: -Properties-
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source -
    
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
        if segue.identifier == "ShowRecipeSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let detailVC = segue.destination as! RecipeDetailViewController
            detailVC.recipe = recipes[indexPath.row]
        }
     }
     
    
}
