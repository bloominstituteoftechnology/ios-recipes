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
    var recipeController = RecipeController.recipeController

    
    // MARK: - IBOutlets
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeTextView: UITextView!
    
    
    // MARK: - IBActions
    @IBAction func editButton(_ sender: Any) {
        recipeTextView.isEditable = true
    }
    
    @IBAction func saveRecipeButton(_ sender: Any) {
        if recipeTextView.isEditable == true {
            guard let name = recipe?.name,
                let instructions = recipeTextView.text
                else { return }
            recipeController.updateRecipe(name: name, instructions: instructions)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
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
