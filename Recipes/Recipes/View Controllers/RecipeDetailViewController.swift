//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Hector Steven on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	
	func updateViews() {
		guard let recipe = recipe else { return }
		
		recipeNameLabel?.text = recipe.name
		recipeTextView?.text = recipe.instructions
	}

	
	@IBOutlet var recipeNameLabel: UILabel!
	@IBOutlet var recipeTextView: UITextView!
	
	
	var recipe: Recipe? {
		didSet {
			updateViews()
		}
	}

}
