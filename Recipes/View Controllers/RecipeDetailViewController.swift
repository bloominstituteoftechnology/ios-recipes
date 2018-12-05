//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jaspal on 12/4/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        if let recipe = recipe {
            recipeNameLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }

}
