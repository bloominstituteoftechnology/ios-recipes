//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Waseem Idelbi on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: -IBOutlets-
    
    @IBOutlet var recipeTitleLabel: UILabel!
    @IBOutlet var instructionsTextView: UITextView!
    
    
    //MARK: -Properties-
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: -Methods-
    
    func updateViews() {
        guard let unwrappedRecipe = recipe, isViewLoaded else {return}
        recipeTitleLabel.text = unwrappedRecipe.name
        instructionsTextView.text = unwrappedRecipe.instructions
    }
    
    
} //End of class
