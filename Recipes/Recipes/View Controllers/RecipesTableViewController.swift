//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
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
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

		cell.textLabel?.text = recipes[indexPath.row].name
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowRecipe" {
			guard let dest = segue.destination as? RecipeDetailViewController,
			let cell = sender as? UITableViewCell,
			let indexPath = tableView.indexPath(for: cell)
			else { return }
			dest.recipe = recipes[indexPath.row]
		}
	}
}
