//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jeffrey Carpenter on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDirectionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = recipe?.name
    }
    
    private func updateViews() {
        
        guard let recipe = recipe,
        self.isViewLoaded
        else { return }
        
        recipeNameLabel.text = recipe.name
        recipeDirectionsTextView.text = recipe.instructions
    }
}
