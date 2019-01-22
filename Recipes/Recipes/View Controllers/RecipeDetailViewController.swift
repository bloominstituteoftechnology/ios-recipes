//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Moses Robinson on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else {return}
            
            recipeLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }
    
    //MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
}
