//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ryan Murphy on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let recipie = recipe, isViewLoaded else { return }
        recipeLabel.text = recipie.name
        recipeTextView.text = recipie.instructions
        
        }
    }


