//
//  DetailViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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
        //This should take the values of the recipe and place them in the corresponding outlets.
        
        guard let passedInRecipe = recipe else { return }
        if isViewLoaded {
            label.text = passedInRecipe.name
            textView.text = passedInRecipe.instructions
        }
    }
    
}
