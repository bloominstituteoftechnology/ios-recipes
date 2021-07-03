//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Keri Levesque on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeDetailTextLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
   
    // add variable recipe
    var recipes: [Recipe]?
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    // create function update views
    func updateViews() {
        if self.isViewLoaded, let recipe = recipe {
            recipeDetailTextLabel.text = recipe.name
            recipeDetailTextView.text = recipe.instructions
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
