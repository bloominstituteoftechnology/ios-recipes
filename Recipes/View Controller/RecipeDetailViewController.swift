//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Andrew Ruiz on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeLabel: UILabel!
    
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
        guard let name = recipe?.name,
            let instructions = recipe?.instructions else { return }

        if isViewLoaded == true {
            recipeLabel.text = name
            recipeTextView.text = instructions
        }
    }
}
