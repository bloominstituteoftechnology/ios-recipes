//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Breena Greek on 3/13/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
    
    func updateViews() {
        if isViewLoaded {
        guard let recipe = recipe else { return }
        recipeTitleLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
        }
    }
}
