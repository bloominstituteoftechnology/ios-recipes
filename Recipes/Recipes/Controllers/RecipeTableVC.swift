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
	private var filteredRecipes = [Recipe]() {
		didSet {
			tableView.reloadData()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		RecipesNetworkClient().fetchRecipes { (recipes, error) in
			if let error = error {
				NSLog("Fatal error: \(error)")
			} else if let recipes = recipes?.sorted(by: {$0.name < $1.name}) {
				self.recipes = recipes
				DispatchQueue.main.async {
					self.filteredRecipes = recipes
				}
			}
		}
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let insructionsVC = segue.destination as? InstructionsVC,
			let indexPath = tableView.indexPathForSelectedRow {
			insructionsVC.recipe = filteredRecipes[indexPath.row]
		}
	}
	
	@IBAction func searchUpdated(_ sender: UITextField) {
		if let search = sender.optionalText?.lowercased() {
			filteredRecipes = recipes.filter({$0.name.lowercased().contains(search)})
		} else {
			filteredRecipes = recipes
		}
	}
	
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = filteredRecipes[indexPath.row].name

        return cell
	}
}

extension UITextField {
	var optionalText: String? {
		let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		return (trimmedText ?? "").isEmpty ? nil : trimmedText
	}
}
