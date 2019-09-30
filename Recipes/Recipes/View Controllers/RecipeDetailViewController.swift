//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Gi Pyo Kim on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    

    private func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        
        nameTextField.text = recipe.name
        detailTextView.text = recipe.instructions
    }

}
