//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jonathan Ferrer on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }

    func updateViews() {
        guard let recipe = recipe, isViewLoaded else { return }
        recipeLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }



    //Mark: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
