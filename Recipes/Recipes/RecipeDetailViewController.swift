//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Wyatt Harrell on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
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
        guard let recipe = recipe, self.isViewLoaded else { return }
        titleLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }

}
