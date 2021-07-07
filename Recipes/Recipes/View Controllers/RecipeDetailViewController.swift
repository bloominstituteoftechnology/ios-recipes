//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Nelson Gonzalez on 1/19/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
        guard let recipe = recipe else {return}
        recipeNameLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
        }
    }

}
