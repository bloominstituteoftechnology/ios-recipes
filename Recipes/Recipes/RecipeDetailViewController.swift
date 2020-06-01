//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    
    @IBOutlet weak var recipeDetailTextView: UITextView!
    @IBOutlet weak var recipeNameTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   

    
    
    func updateViews(){
        guard let recipe = recipe  else {
            title = "No Recipe Selected"
            return }
        
        title = recipe.name
        recipeNameTextLabel.text = recipe.name
        recipeDetailTextView.text = recipe.instructions
        
    }
}
