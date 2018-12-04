//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/4/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews(recipe!)
    }
    

    @IBOutlet weak var recipeDetailViewLabel: UILabel!
    @IBOutlet weak var recipeDetailViewTextView: UITextView!
    
    func updateViews (_ recipe: Recipe) {
    //func updateViews () {
        
        recipeDetailViewLabel.text = recipe.name
        recipeDetailViewTextView.text = recipe.instructions
        
    }
}
