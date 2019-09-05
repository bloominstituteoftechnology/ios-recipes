//
//  RecipesDetailViewController.swift
//  Recipes
//
//  Created by Fabiola S on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    // MARK: Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: Functions
    func updateViews() {
        
        if isViewLoaded {
            if let recipe = recipe {
        recipeNameLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
            }
        }
        
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
