//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by David Williams on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            recipeNameLabel.text = recipe?.name
            updateViews()
        }
    }

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeInstructions: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        recipeNameLabel.text = recipe?.name
        recipeInstructions.text = recipe?.instructions
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
