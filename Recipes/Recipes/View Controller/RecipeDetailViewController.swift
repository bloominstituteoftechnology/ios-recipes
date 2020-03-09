//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Nichole Davidson on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let recipe = recipe {
            if self.isViewLoaded {
        recipeNameLabel.text = recipe.name
        recipeDetailTextView.text = recipe.instructions
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
}
