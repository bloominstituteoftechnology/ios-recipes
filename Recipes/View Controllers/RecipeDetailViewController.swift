//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Dillon P on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIntructionsTextView: UITextView!
    
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        
        recipeNameLabel.text = recipe.name
        recipeIntructionsTextView.text = recipe.instructions
    }

}
