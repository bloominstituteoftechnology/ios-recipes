//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Christopher Aronson on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    var recipes: [Recipe] = [] {
        didSet {
            print("Reloading")
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        print(recipes.count)
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.detailTextLabel?.text = recipes[indexPath.row].name

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetailsViewController" {
            guard let destinationVC = segue.destination as? RecipeDetailViewController else { return }
            
            guard let index = tableView.indexPathForSelectedRow?.row else { return }
            destinationVC.recipe = recipes[index]
        }
    }
}
