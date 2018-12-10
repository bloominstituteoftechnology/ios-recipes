//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Vijay Das on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    let recipe: Recipe?
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeTextView: UITextView!
    
    var recipe: Recipe?
    
    func updateViews() {
        
        let recipeName.text = // ?? - How do we get this?
        let recipeTextView.text =  // ??
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    override var isViewLoaded: Bool {
        // ??
        
        
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
