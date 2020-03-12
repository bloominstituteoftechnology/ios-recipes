//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by David Williams on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeInstructions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        view.backgroundColor = .darkGray
        recipeInstructions.backgroundColor = .lightGray
    }
    
    func updateViews() {
        guard let recipe = recipe else { return }
        if isViewLoaded {
            recipeNameLabel.text = recipe.name
            recipeNameLabel.textColor = .systemRed
            recipeInstructions.text = recipe.instructions
        }
    }
}
