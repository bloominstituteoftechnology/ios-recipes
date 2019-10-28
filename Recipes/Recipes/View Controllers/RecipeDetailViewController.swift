//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by morse on 10/27/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
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
        if self.isViewLoaded, let recipe = recipe {
            
            recipeLabel.text = recipe.name
            textView.text = recipe.instructions
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
