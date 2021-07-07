//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lambda_School_loaner_226 on 3/14/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
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
        guard let recipe = recipe, isViewLoaded else {
            recipeNameLabel?.text = nil
            recipeTextView?.text = nil
            return
        }
        
        recipeNameLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }
}
