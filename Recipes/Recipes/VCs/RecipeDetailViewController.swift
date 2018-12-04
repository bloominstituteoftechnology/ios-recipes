//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Madison Waters on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        
        guard let recipe = recipe,
            isViewLoaded else { return } // isViewLoaded Here
        
        recipeLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
        
    }
    
    var recipe: Recipe? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
}
