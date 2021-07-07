//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Gerardo Hernandez on 1/21/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: = Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Functions
    
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        nameLabel.text = recipe.name
        textView.text = recipe.instructions
        
    }

}
