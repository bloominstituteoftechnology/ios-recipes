//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_241 on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // Mark:- IBOutlets/Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recipeTextField: UITextView!
    var recipe: Recipe? {
        didSet {
            updateViews()
            // updateViews method
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        guard let rec = recipe, self.isViewLoaded else { return }
        
        nameLabel.text = rec.name
        recipeTextField.text = rec.instructions
        
        
        
        
    }
    


}
