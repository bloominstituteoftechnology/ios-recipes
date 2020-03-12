//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Claudia Contreras on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var recipeTitleLabel: UILabel!
    @IBOutlet var recipeDetailTextView: UITextView!
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Functions
    func updateViews() {
        if let recipe = recipe,
            isViewLoaded {
            recipeTitleLabel.text = recipe.name
            recipeDetailTextView.text = recipe.instructions
        }
    }
    
    
}
