//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Thomas Cacciatore on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let chosenRecipe = recipe else { return }
        detailLabel.text = chosenRecipe.name
        detailTextView.text = chosenRecipe.instructions
    }

    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    

}
