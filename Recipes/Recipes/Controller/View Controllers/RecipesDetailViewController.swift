//
//  RecipesDetailViewController.swift
//  Recipes
//
//  Created by Kenny on 1/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    let coreDataController = CoreDataController.instance
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        nameTextView.delegate = self
        instructionsTextView.delegate = self
    }
    
    func updateViews() {
        guard let nameTextView = nameTextView,
            let recipeTextView = instructionsTextView
        else {return}
        nameTextView.textContainer.maximumNumberOfLines = 2
        nameTextView.allowsEditingTextAttributes = false
        nameTextView.text = recipe?.name
        recipeTextView.text = recipe?.instructions
    }

}

extension RecipesDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let recipe = recipe else {return}
        switch textView {
        case nameTextView:
            coreDataController.updateRecipeName(recipe: recipe, name: textView.text)
        case instructionsTextView:
            coreDataController.updateRecipeInstructions(recipe: recipe, instructions: textView.text)
        default:
            break
        }
        
    }
}
