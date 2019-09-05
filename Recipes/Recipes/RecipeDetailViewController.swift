//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Casualty on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeInstructions: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            recipeTitle.text = recipe.name
            recipeInstructions.text = recipe.instructions
            title = "Recipe - \(recipe.name)"
        }
    }
    
}
