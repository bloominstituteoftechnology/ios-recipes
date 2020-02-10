//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Elizabeth Wingate on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeText: UITextView!
    
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

           if isViewLoaded {
               if let recipe = recipe {
           recipeLabel.text = recipe.name
           recipeText.text = recipe.instructions
               }
           }
    }

}
