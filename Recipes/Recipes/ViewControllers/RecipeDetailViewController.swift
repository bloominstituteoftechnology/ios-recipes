//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Thomas Cacciatore on 5/20/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.updateViews()
        }
      
    }
    
    func updateViews() {
        guard let unwrappedRecipe = recipe, isViewLoaded == true else { return }
        detailLabel.text = unwrappedRecipe.name
        detailTextView.text = unwrappedRecipe.instructions
    }
    
        // Mark: - Properties
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
}
