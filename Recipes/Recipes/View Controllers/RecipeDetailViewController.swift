//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Shawn Gee on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - Properties
    
    var recipe: Recipe? { didSet { updateViews() } }
    
    
    //MARK: - Private
    
    func updateViews() {
        if isViewLoaded,
           let recipe = recipe {
            titleLabel.text = recipe.name
            bodyTextView.text = recipe.instructions
        }
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
}
