//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Scott Bennett on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
 
    
    func updateViews() {
        guard isViewLoaded else { return }
        detailLabel.text = recipe?.name
        detailTextView.text = recipe?.instructions
    }
    



}
