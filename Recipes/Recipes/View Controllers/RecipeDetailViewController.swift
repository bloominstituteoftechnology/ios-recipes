//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jessie Ann Griffin on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    // MARK: Properties
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
        //if self.isViewLoaded {
            guard let recipe = recipe, self.isViewLoaded else { return }
            titleLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        //}
    }
}
