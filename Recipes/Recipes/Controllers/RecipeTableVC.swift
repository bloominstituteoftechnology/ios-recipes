//
//  RecipeTableVC.swift
//  Recipes
//
//  Created by Jeffrey Santana on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableVC: UITableViewController {

	@IBOutlet weak var searchTextField: UITextField!
	
	private var recipes = [Recipe]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		RecipesNetworkClient().fetchRecipes { (recipes, error) in
			if let error = error {
				NSLog("Fatal error: \(error)")
			} else if let recipes = recipes {
				self.recipes = recipes
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let insructionsVC = segue.destination as? InstructionsVC,
			let indexPath = tableView.indexPathForSelectedRow {
			insructionsVC.recipe = recipes[indexPath.row]
		}
	}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
	}
}
