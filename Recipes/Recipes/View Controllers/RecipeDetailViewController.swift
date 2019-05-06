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

	@IBOutlet var instructionsTextView: UITextView!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateViews()
	}

	func updateViews() {
		guard let recipe = recipe, isViewLoaded else { return }
		navigationItem.title = recipe.name
		instructionsTextView.text = recipe.instructions
	}

}
