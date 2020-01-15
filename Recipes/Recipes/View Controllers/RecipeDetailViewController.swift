//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Alexander Supe on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var recipeDetails: UITextView!
    
    // MARK: - Variables
    var recipe: Recipe? {
        didSet { updateViews() }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Basic Functions
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else {  return  }
        self.title = recipe.name
        recipeDetails.text = recipe.instructions
    }
    
}
