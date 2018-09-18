//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? {
        didSet {
            if isViewLoaded {
            updateViews()
        }
    }
    }
    
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeInstructionsTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    // Check that the view is loaded when unwrapping the recipe object by using the view controller's isViewLoaded property.
    func updateViews(){
       guard let recipe = recipe, isViewLoaded else { return }
        recipeLabel.text = recipe.name
        recipeInstructionsTextField.text = recipe.instructions
    }

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
