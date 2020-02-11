//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Enrique Gongora on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    //MARK: - IBOutlets/Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var recipe: Recipe?{
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let recipe = recipe else { return }
        if isViewLoaded {
            titleLabel.text = recipe.name
            textView.text = recipe.instructions
        }
    }
}
