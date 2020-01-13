//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Zack Larsen on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else {
            
            recipeName?.text = nil
            recipeDetails?.text = nil
            return
        }
        
        recipeName.text = recipe.name
        recipeDetails.text = recipe.instructions
    }
    
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
}
