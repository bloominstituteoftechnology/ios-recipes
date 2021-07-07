//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Brandi on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
           updateViews()
        }
    }

    @IBOutlet weak var RecipeNameLabel: UILabel!
    @IBOutlet weak var RecipeDetailText: UITextView!
    
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
    
    func updateViews() {
        
        if isViewLoaded {
            if let recipe = recipe {
                RecipeNameLabel.text =  recipe.name
                RecipeDetailText.text = recipe.instructions
            }
        }
        
    }

}
