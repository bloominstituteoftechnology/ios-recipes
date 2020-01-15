//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by David Wright on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
    
    // MARK: - Properties

    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods

    func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        
        recipeNameLabel.text = recipe.name
        recipeInstructionsTextView.text = recipe.instructions
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
