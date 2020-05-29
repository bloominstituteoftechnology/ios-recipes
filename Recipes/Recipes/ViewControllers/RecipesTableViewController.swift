//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by John Pitts on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RecipeDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let detailVC = segue.destination as? RecipeDetailViewController else {return}
                    detailVC.recipe = recipes[indexPath.row]
        }
    }

    

}
