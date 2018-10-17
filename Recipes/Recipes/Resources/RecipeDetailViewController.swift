//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Yvette Zhukovsky on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    
    
    func updateViews(){
        
        if let rec = recipe {
            if self.isViewLoaded {
                label.text = rec.name
                textView.text = rec.instructions
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
