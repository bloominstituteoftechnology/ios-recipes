//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by denis cedeno on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var recipeLabel: UILabel!
    
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
        guard let recipe = recipe else {return}
        
        if self.isViewLoaded{
            recipeLabel.text = recipe.name
            detailsTextView.text = recipe.instructions
        }
        
    }

}
