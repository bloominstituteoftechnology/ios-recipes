//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Andrew Dhan on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    func updateViews(){
        guard let recipe = recipe, isViewLoaded else {return}
        titleLabel.text = recipe.name
        textView.text = recipe.instructions
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: Properties
    var recipe:Recipe?{
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
}
