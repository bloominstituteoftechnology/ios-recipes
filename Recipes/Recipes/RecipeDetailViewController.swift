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
            
            if recipe.difficulty == "Easy" {
                difficultyLabel.textColor = .green
            } else if recipe.difficulty == "Medium" {
                difficultyLabel.textColor = .yellow
            } else {
                difficultyLabel.textColor = .red
            }
            
            recipeInstructions.text = recipe.instructions
            ingredientsTextView.text = recipe.ingredients
            difficultyLabel.text = recipe.difficulty
            totalTimeLabel.text = recipe.totalTime
            prepTimeLabel.text = recipe.prepTime
            cookTimeLabel.text = recipe.cookTime
            servingsLabel.text = recipe.servings
            mealTimeLabel.text = recipe.mealTime
            title = recipe.name
        }
    }
    
}
