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
        
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        recipeTitleLabel.text = recipe.name
       recipeInstructionsTextView.text = recipe.instructions
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.isEnabled = true
    //     _ = navigationController?.view.snapshotView(afterScreenUpdates: true)
    }
}
