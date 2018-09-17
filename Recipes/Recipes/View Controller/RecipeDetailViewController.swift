//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Iyin Raphael on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        guard isViewLoaded else {return}
        if let recipe = recipe{
            nameLabel.text = recipe.name
            textView.text = recipe.instructions
        }
    }
    var recipe: Recipe?{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
  
    
    

}
