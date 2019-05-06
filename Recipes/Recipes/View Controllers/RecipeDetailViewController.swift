//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Sameera Roussi on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    // MARK: - View states
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // updateViews()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViews()
    }
    
    private func updateViews() {
        recipeTitleLabel.text = recipe?.name ?? "No title provided"
       // recipeInstructionsTextView.text = recipe?.instructions ?? "Sorry, instructions are unavailable at this time."
    }
}
