//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Bradley Diroff on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let recipe = recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.name

        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            guard let vc = segue.destination as? RecipeDetailViewController else {return}
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.recipe = recipes[indexPath.row]
            }
        }
    }
    

}
