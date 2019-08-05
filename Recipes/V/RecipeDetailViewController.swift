//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Nathan Hedgeman on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeDetailsTextView: UITextView!
    
    var recipe: Recipe? {
        
        didSet {
            
            updateViews()
            
        }
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    func updateViews() {
        
        if isViewLoaded {
            
            recipeNameLabel.text = recipe?.name
            recipeDetailsTextView.text = recipe?.instructions
            
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
