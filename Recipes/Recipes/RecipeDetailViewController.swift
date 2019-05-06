//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    private func updateViews(){
        guard let passedInRecipe = recipe, isViewLoaded else { return }
        label.text = passedInRecipe.name
        textView.text = passedInRecipe.instructions
    }
}
