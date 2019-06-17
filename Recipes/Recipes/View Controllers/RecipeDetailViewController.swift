//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Alex Shillingford on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    // MARK: - Navigation
    func updateViews() {
        recipeLabel.text = recipe?.name
        textView.text = recipe?.instructions
    }
}
