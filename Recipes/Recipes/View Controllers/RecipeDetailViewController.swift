//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/4/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeDetailViewLabel: UILabel!
    @IBOutlet weak var recipeDetailViewTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews () {
//        guard isViewLoaded else { return }
//        if let recipe = recipe {
//            recipeDetailViewLabel.text = recipe.name
//            recipeDetailViewTextView.text = recipe.instructions
//        }
        
        if isViewLoaded {
            guard let recipe = recipe else { fatalError("Hello") }
            
            recipeDetailViewLabel.text = recipe.name
            recipeDetailViewTextView.text = recipe.instructions
        }
    }
}
