//
//  RecipesDetailedViewController.swift
//  Recipes
//
//  Created by Nathan Hedgeman on 7/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailedViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var recipesNameLable: UILabel!
    @IBOutlet weak var recipesTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
        
    }
    var detailedVC = RecipesDetailedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    //functions
    func updateViews() {
        
        if detailedVC.isViewLoaded {
            guard let thisRecipe = recipe else {return}
            recipesTextView.text = thisRecipe.instructions
            recipesNameLable.text = thisRecipe.name
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
