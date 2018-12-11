//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit
import Foundation

class RecipeDetailViewController: UIViewController {
    
    // Outlets and Actions
    @IBOutlet weak var RecipeTitle: UILabel!
    @IBOutlet weak var RecipeInstructions: UITextView!
    
    // Variables and Constants
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { fatalError("Recipe Error") }
            RecipeTitle.text = recipe.name
            RecipeInstructions.text = recipe.instructions
        }
    }
}

