//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Bradley Diroff on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var recipeTextView: UITextView!
    
    
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
    
    func updateViews() {
        if let recipe = recipe {
            if self.isViewLoaded {
                nameLabel.text = recipe.name
                recipeTextView.text = recipe.instructions
            }
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
