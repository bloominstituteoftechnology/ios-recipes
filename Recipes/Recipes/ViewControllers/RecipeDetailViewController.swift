//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by John Pitts on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        
        if isViewLoaded {
        guard let recipe = recipe else {return}
            
            labelTitle.text = recipe.name
            textViewContent.text = recipe.instructions
        }
        
        
    }

    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var textViewContent: UITextView!
    
}
