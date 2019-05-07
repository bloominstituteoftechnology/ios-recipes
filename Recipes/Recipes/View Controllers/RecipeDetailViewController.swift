//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

	var recipe: Recipe? {
		didSet {
			updateViews()
		}
	}
	var recipeInstructions: [String] = [] {
		didSet {
			tableView.reloadData()
		}
	}

	@IBOutlet var tableView: UITableView!
	//	@IBOutlet var instructionsTextView: UITextView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateViews()
	}

	func createRecipeInstructions() {
		guard let recipe = recipe, isViewLoaded else { return }
		recipeInstructions = recipe.instructions.split(separator: "\n").map { String($0) }
	}

	func updateViews() {
		guard let recipe = recipe, isViewLoaded else { return }
		navigationItem.title = recipe.name
//		instructionsTextView.text = recipe.instructions
		createRecipeInstructions()
	}

}

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recipeInstructions.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ReceipeDetailCell", for: indexPath)
		guard let instructionCell = cell as? RecipeTableViewCell else { return cell }

		instructionCell.instructionTextLabel.text = recipeInstructions[indexPath.row]
		return instructionCell
	}
}
