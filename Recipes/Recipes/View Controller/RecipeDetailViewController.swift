//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Hayden Hastings on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        guard isViewLoaded else { return }
        if let name = recipe?.name,
            let instructions = recipe?.instructions {
            recipeNameLabel.text = name
            recipeIngredientTextView.text = instructions
        }
    }
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
}
