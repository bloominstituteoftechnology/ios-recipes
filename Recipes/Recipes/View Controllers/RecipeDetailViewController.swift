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
        guard let recipe = recipe, self.isViewLoaded else {return}
        recipeTitleLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
    }
    
    
} //End of class
