//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Bhawnish Kumar on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    
    func updateViews() {
        if isViewLoaded {
        guard let newRecipe = recipe else { return }
        recipeLabel.text = newRecipe.name
        recipeTextView.text = newRecipe.instructions
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

}
