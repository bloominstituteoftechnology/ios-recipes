//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Farhan on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        if isViewLoaded{
            guard let recipe = recipe else {return}
            titleLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
    }

    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
}
