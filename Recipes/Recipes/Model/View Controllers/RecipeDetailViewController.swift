//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Gavin Murphy on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeInstructionsText: UITextView!
    
    // MARK: - Properties
    
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
    

    // MARK: - Private
    
    func updateViews() {
        guard let recipe = recipe else { return }

        recipeTitleLabel.text = recipe.name
        recipeInstructionsText.text = recipe.instructions
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
