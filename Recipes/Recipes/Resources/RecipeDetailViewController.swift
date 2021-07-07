//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Chris Gonzales on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var recipe: Recipe?{
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Methods
    
    func updateViews(){
        guard let recipe = recipe,
            isViewLoaded else { return }
        RecipeTitleLabel.text = recipe.name
        RecipeInstructionText.text = recipe.instructions
    }
    
    // MARK: -Outlets
    
    @IBOutlet weak var RecipeTitleLabel: UILabel!
    
    @IBOutlet weak var RecipeInstructionText: UITextView!
    
    
    // MARK: - View Lifecycle
    
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
