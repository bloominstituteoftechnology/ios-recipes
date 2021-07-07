//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ciara Beitel on 9/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if !isViewLoaded { return }
        guard let recipe = recipe else { return }
        recipeNameLabel.text = recipe.name
        recipeInstructionsTextView.text = recipe.instructions
    }
}
