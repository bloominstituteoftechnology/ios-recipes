//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jeremy Taylor on 5/12/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        
        recipeNameLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
}
