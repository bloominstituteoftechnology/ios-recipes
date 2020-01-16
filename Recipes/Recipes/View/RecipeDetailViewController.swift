//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Sal Amer on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    //IBOutlets
    
    @IBOutlet weak var recipeNameTxtLbl: UILabel!
    @IBOutlet weak var recipeIntructionsTextLbl: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else { return }
    
        recipeNameTxtLbl.text = recipe.name
        recipeIntructionsTextLbl.text = recipe.instructions
    
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
