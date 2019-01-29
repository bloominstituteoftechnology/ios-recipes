//
//  RecipesDetailViewController.swift
//  Recipes
//
//  Created by Vijay Das on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recipesTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard isViewLoaded else { return }
        
        if let recipe = recipe {
            nameLabel.text = recipe.name
            recipesTextView.text = recipe.instructions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
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
