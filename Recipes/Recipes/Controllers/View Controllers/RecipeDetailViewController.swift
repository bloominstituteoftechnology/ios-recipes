//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Aaron Cleveland on 1/12/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if self.isViewLoaded {
            guard let name = recipe?.name,
                let instructions = recipe?.instructions else { return }
            textFieldLabel.text = name
            textView.text = instructions
        }
    }
}
