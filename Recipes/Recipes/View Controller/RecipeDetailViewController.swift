//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Eoin Lavery on 15/01/2020.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    //MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: Private Functions
    private func updateViews() {
        guard let recipe = recipe,
        isViewLoaded else {
            print("No recipe item found!")
            return
        }
        
        recipeNameLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }

}
