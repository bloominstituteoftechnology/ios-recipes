//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Eoin Lavery on 04/09/2019.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeGuideTextView: UITextView!
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe"
        updateViews()
    }

    // MARK: - Private Functions
    private func updateViews() {
        if self.isViewLoaded {
            guard let recipe = recipe else { return }
            recipeNameLabel.text = recipe.name
            recipeGuideTextView.text = recipe.instructions
        }
    }
    
}
