//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Paul Yi on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            recipeLabel?.text = recipe.name
            recipeTextView?.text = recipe.instructions
            
        }
    }

}
