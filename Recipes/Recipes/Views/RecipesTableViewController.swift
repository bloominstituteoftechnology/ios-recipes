//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Breena Greek on 3/13/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let detailVC = segue.destination as! RecipeDetailViewController
            detailVC.recipe = recipes[indexPath.row]
        }
    }
}
