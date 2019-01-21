//
//  RecipesDetailViewController.swift
//  TheRecipes
//
//  Created by Michael Flowers on 1/21/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
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
    
    func updateViews(){
        if viewIfLoaded != nil {
            guard let passedInRecipe = recipe else { return }
            label.text = passedInRecipe.name
            textView.text = passedInRecipe.instructions
        }
    }

}
