//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	let networkClient = RecipesNetworkClient()
	var allRecipes: [Recipe] = [] {
		didSet {
			filterRecipes()
		}
	}
	var filteredRecipes: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = filteredRecipes
		}
	}
	var recipesTableViewController: RecipesTableViewController? {
		didSet {
			recipesTableViewController?.recipes = filteredRecipes
		}
	}

	@IBOutlet var recipeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

		networkClient.fetchRecipes { (recipes, error) in
			guard error == nil else {
				print("ERRORINATED: \(error!)")
				return
			}

			if let recipes = recipes {
				DispatchQueue.main.async {
					self.allRecipes = recipes
				}
			}
		}
	}

	func filterRecipes() {
		guard let searchText = recipeTextField.text, !searchText.isEmpty else {
			filteredRecipes = allRecipes
			return
		}
		filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) ||
			$0.instructions.lowercased().contains(searchText.lowercased()) }
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbedRecipesTableViewController" {
			let dest = segue.destination as? RecipesTableViewController
			recipesTableViewController = dest
		}
	}

	@IBAction func recipeTextFieldChanged(_ sender: UITextField) {
		filterRecipes()
	}

	@IBAction func recipeTextFieldEdited(_ sender: UITextField) {
		resignFirstResponder()
		filterRecipes()
	}
}
