//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_201 on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let recipe = recipe, self.isViewLoaded {
            recipeLabel.text = recipe.name
            recipeTextView.text = recipe.instructions
        }
        //collectionViewCellOutlet.text = photo.title
        //imageViewOutlet.image = UIImage(data: photo.imageData)
    }
    
}
