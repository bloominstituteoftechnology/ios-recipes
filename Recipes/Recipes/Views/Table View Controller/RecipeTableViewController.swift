//
//  RecipeTableViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
            print("Recipes array set in table view")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            guard let destinationVC = segue.destination as? RecipeDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.recipe = recipes[indexPath.row]
        }
    }
}
