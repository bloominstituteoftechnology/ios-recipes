//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func updateViews() {
        guard let recipe = recipe else { return }
        
        titleLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }
}
