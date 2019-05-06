//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Christopher Aronson on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe? {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var recipeDetailNameLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    private func updateView() {
        if isViewLoaded {
            guard let name = recipe?.name,
            let instructions = recipe?.instructions
                else { return }
            
            recipeDetailNameLabel.text = name
            recipeDetailTextView.text = instructions
        }
    }
}
