//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Sameera Leola on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var receipeDetailTextView: UITextView!
    
   // private var studentTableViewController: StudentTableViewController!
    
    var recipe: Recipe? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
//        if viewController.viewIfLoaded?.window != nil {
//            // viewController is visible
//        }
        if (self.isViewLoaded) {
            recipeTitle.text = recipe?.name
            receipeDetailTextView.text = recipe?.instructions
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
