//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jonalynn Masters on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // MARK: Properties
    var recipe: Recipe? {
    didSet {
        updateViews() // call update views in the didSet or the recipe variable
        }
    }
    // MARK: Outlets
    
    @IBOutlet var recipeLabel: UILabel!
    
    @IBOutlet var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews() // call update views in the viewDidLoad method
    }
    
    //MARK: Methods
    // update views function: take in the values of the 'recipe' and place them in the corresponding outlets
    // check that the view is loaded when unwrapping the 'recipe' object
    func updateViews() {
        if self.isViewLoaded { // isViewLoaded property to check if the view is loaded
            guard let recipeUnwrapped = recipe else { return }
            recipeLabel.text = recipeUnwrapped.name
            recipeTextView.text = recipeUnwrapped.instructions
        } else {
            print("Error loading recipe instructions.")
        }
    }
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

