//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lydia Zhang on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intro: UITextView!
    
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
        if let receipe = recipe, self.isViewLoaded == true {
            name.text = receipe.name
            intro.text = receipe.instructions
        }
    }

}
