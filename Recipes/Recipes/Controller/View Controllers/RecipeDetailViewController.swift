//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Chad Rutherford on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private
    private func updateViews() {
        guard let recipe = recipe, self.isViewLoaded else { return }
        titleLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
    }
}
