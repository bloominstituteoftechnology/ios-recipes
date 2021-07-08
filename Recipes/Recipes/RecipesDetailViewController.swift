//
//  RecipesDetailViewController.swift
//  Recipes
//
//  Created by Victor  on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation
import UIKit

class RecipesDetailViewController: UIViewController {
    //connecting outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    //checking for data transferred
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //updates outlets
    func updateViews() {
        guard let recipe = recipe, isViewLoaded else {return}
        titleLabel.text = recipe.name
        textView.text = recipe.instructions
        
    }
}
