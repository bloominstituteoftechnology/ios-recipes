//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Nathanael Youngren on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let recipe = recipe else { return }
        if isViewLoaded {
            recipeTitleLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

}
