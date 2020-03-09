//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Karen Rodriguez on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeInstructionsView: UITextView!
    
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation


    func updateViews() {
        guard let recipe = recipe else { fatalError("Oopsie") }
        
        if isViewLoaded {
            recipeTitleLabel.text = recipe.name
            recipeInstructionsView.text = recipe.instructions
        }
    }
}
