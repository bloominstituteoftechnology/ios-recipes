//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Ilgar Ilyasov on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var instructionTextView: UITextView!
    
    var recipe: Recipe? {
        didSet { updateViews() }
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        if isViewLoaded {
            guard let name = recipe?.name,
                let instruction = recipe?.instructions else { return }
        
            recipeNameLabel.text = name
            instructionTextView.text = instruction
        }
    }
}
