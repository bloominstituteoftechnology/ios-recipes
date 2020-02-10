//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_268 on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateviews()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeText: UITextView!

    var recipe: Recipe? {
        didSet {
            updateviews()
            }
        }
    
    
    func updateviews() {
        if isViewLoaded {
            if let recipe = recipe {
                recipeLabel.text = recipe.name
                recipeText.text = recipe.instructions
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

