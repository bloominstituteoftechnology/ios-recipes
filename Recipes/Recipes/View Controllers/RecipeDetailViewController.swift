//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Niranjan Kumar on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeDetail: UITextView!


    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    
    
    private func updateViews() {
        guard let recipe = recipe else { return }
        
        if self.isViewLoaded {
        recipeLabel.text = recipe.name
        recipeDetail.text = recipe.instructions
        } else {
            return
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
