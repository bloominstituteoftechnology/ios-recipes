//
//  RecipesDetailViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        
        if isViewLoaded {
        label.text = recipe?.name
        textView.text = recipe?.instructions
        }
    }
    
    
    
}
