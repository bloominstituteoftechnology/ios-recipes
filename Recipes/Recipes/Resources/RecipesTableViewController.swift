//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Fabiola S on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // MARK: Properties
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTitleCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailSegue" {
            if let recipeDetailVC = segue.destination as? RecipeDetailViewController {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[indexPath.row]
            recipeDetailVC.recipe = recipe
        }
        } else {
            print("Error")
        }
    }

}
