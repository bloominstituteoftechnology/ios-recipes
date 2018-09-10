//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    var recipeController: RecipeController?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    // MARK - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func saveRecipe(_ sender: Any) {
        guard let recipe = recipe,
            let name = titleLabel.text,
            let instructions = recipeTextView.text, !instructions.isEmpty else { return }
        
        recipeController?.update(recipe, name: name, instructions: instructions)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Utility Methods
    func updateViews() {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
        title = recipe.name
    }
}
