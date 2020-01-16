//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Morgan Smith on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeText: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let recipe = recipe, self.isViewLoaded == true else { return }
        
        recipeLabel.text = recipe.name
        recipeText.text = recipe.instructions
    }
    
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
