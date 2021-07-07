//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Tobi Kuyoro on 13/01/2020.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeLabel: UILabel!
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
        guard isViewLoaded,
            let recipe = recipe else { return }
            recipeLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
    }
}
