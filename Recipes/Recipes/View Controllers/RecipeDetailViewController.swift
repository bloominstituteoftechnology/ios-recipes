//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Moses Robinson on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Properties
    
    var recipe: Recipe?
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
}
