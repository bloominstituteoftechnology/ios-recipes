//
//  DetailVC.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textView: UITextView!
  
  var recipe: Recipe?
  var recipeController: RecipeStorage?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let recipe = recipe {
      label.text = recipe.name
      textView.text = recipe.instructions
      
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Edit to random String because I'm lazy to modify the UI to edit
    recipeController?.update(recipe!, name: UUID().uuidString, instructions: UUID().uuidString)
  }
}
