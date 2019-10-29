//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeDesciption: UITextView!
    
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

    
    // MARK:  Function
    func updateViews(){

        
        if isViewLoaded {
            if let recipe = recipe {
            recipeNameLabel.text = recipe.name
            recipeDesciption.text = recipe.instructions
        }
        }

    }
    
}
