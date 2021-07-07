//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Taylor Lyles on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
	
	var recipe: Recipe? {
		didSet {
			updateViews()
		}
	}
	
	
	private func updateViews() {
		if isViewLoaded {
		guard let name = recipe?.name,
		let instruct = recipe?.instructions
		else { return }
		
		recipeLabel.text = name
		recipeText.text = instruct
	}
}

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    

	@IBOutlet weak var recipeLabel: UILabel!
	@IBOutlet weak var recipeText: UITextView!
	
}
