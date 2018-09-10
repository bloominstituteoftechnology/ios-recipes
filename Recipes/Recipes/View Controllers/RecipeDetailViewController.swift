//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jason Modisett on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else { return }
        
        recipeTitleLabel.text = recipe.name
        recipeBodyTextView.text = recipe.instructions
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var recipe: Recipe? { didSet { updateViews() }}

    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeBodyTextView: UITextView!
    
}
