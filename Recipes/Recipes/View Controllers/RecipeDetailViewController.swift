//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Linh Bouniol on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    var recipeController: RecipeController?
    
    // MARK: - Outlets/Actions
    
    @IBOutlet var recipeLabel: UILabel!
    @IBOutlet var recipeTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        guard let instructions = recipeTextView.text, let recipe = recipe else { return }
        
        recipeController?.update(recipe: recipe, name: recipe.name, instructions: instructions)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    // MARK: - Methods
    
    func updateViews() {
        // Check if the view is loaded
        if isViewLoaded {
            // Get the recipe
            guard let recipe = recipe else { return }
            
            recipeLabel?.text = recipe.name
            recipeTextView?.text = recipe.instructions
        }
    }
}
