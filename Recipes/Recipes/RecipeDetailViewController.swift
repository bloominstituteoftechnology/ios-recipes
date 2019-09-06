//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Casualty on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeInstructions: UITextView!
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    @IBOutlet weak var servingsLabel: UILabel!
    
    @IBOutlet weak var mealTimeLabel: UILabel!
    
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
            recipeInstructions.text = recipe.instructions
            ingredientsTextView.text = "Ingredients: \(recipe.ingredients)"
            difficultyLabel.text = "Level: \(recipe.difficulty)"
            totalTimeLabel.text = "Total: \(recipe.totalTime)"
            prepTimeLabel.text = "Prep: \(recipe.prepTime)"
            cookTimeLabel.text = "Cook: \(recipe.cookTime)"
            servingsLabel.text = "Servings: \(recipe.servings)"
            mealTimeLabel.text = "Meal: \(recipe.mealTime)"
            title = recipe.name
        }
    }
    
}
