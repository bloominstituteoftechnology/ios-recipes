//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Chad Parker on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!

    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

    private func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else { return }

        titleLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
    }
}
