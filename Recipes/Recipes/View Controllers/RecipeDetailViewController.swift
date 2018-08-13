//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Lisa Sampson on 8/13/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            foodLabel?.text = recipe.name
            instructionsTextView?.text = recipe.instructions
        }
    }
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
}
