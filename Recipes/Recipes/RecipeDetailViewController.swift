//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Mitchell Budge on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe? {
        didSet {
        updateViews()
        }
    }
    
    
    func updateViews() {
        recipeDetailLabel.text = recipe?.name
        recipeDetailTextView.text = recipe?.instructions
        guard let _ = recipe,
            isViewLoaded else { return }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var recipeDetailLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
