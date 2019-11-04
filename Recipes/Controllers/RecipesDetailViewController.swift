//
//  RecipesDetailViewController.swift
//  Recipes
//
//  Created by Alex Thompson on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
     var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    func updateViews () {
        if let recipe = recipe,
            self.isViewLoaded {
            recipeLabel.text = recipe.name
            recipeInstructionsTextView.text = recipe.instructions
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
