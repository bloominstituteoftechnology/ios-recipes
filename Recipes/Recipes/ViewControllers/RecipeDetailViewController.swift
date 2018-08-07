//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Carolyn Lea on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController
{
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var instructionTextView: UITextView!
    var recipe: Recipe?
    {
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateViews()
    }

    func updateViews()
    {
        let recipeName = recipe?.name
        guard let recipe = recipe else {return}
        
        if self.isViewLoaded
        {
            recipeTitleLabel.text = recipeName
            instructionTextView.text = recipe.instructions
        }
        else
        {
            print("There was a problem loading the view.")
        }
        
    }
}
