//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jocelyn Stuart on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        
        recipeNameLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
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
