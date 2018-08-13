//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lisa Sampson on 8/13/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            foodLabel?.text = recipe.name
            instructionsTextView?.text = recipe.instructions
        }
    }
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
}
