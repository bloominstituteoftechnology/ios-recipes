//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Zack Larsen on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeDetails: UILabel!
//    updateViews() {
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    var recipe: Recipe?
    func updateViews() {
        recipeName.text = re
        
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
