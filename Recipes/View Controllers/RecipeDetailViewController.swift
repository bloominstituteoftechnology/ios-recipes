//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Welinkton on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? {
        didSet{
            updateViews()
            viewDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateViews(){
        if isViewLoaded{
            guard let name = recipe?.name,
                let instructions = recipe?.instructions else {return}
            
        recipeLabel.text = name
        instructionsTextView.text = instructions
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var instructionsTextView: UITextView!

}
