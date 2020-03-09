//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_259 on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    
    // MARK: - IBOutlets
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        recipeNameLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }

}
