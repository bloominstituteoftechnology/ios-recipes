//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by scott harris on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var instructionsTextField: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if let recipe = recipe,
            isViewLoaded {
            recipeLabel.text = recipe.name
            instructionsTextField.text = recipe.instructions
            
        }
    }
    
    
}
