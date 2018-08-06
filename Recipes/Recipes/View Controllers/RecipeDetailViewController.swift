//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Linh Bouniol on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet var recipeLabel: UILabel!
    @IBOutlet var recipeTextView: UITextView!
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    // MARK: - Methods
    
    func updateViews() {
        // Check if the view is loaded
        if isViewLoaded {
            // Get the recipe
            guard let recipe = recipe else { return }
            
            recipeLabel?.text = recipe.name
            recipeTextView?.text = recipe.instructions
        }
    }
}
