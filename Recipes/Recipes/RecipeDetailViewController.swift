//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Kobe McKee on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else { return }
        
        recipeLabel.text = recipe.name
        recipeTextView.text = recipe.instructions   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeTextView: UITextView!


}
