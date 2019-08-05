//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Conner on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeTextView: UITextView!
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
        if let recipe = recipe {
            if (self.isViewLoaded) {
                recipeNameLabel.text = recipe.name
                recipeTextView.text = recipe.instructions
            }
        }
    }

}
