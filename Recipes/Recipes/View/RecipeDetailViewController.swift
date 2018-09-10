//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    // MARK - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - Private Utility Methods
    func updateViews() {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }
}
