//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Bradley Diroff on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var recipeTextView: UITextView!
    
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
        if let recipe = recipe {
            if self.isViewLoaded {
                nameLabel.text = recipe.name
                recipeTextView.text = recipe.instructions
            }
        }
    }

    
    // MARK: - Navigation


}
