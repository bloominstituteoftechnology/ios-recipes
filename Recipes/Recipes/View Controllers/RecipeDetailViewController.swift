//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by morse on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
            print(recipe?.name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        // Is this what was meant by "Check that the view is loaded when unwrapping the recipe object by using the view controller's isViewLoaded property."?
        if self.isViewLoaded {
            guard let name = recipe?.name, let instructions = recipe?.instructions else { return }
            textLabel.text = name
            textView.text = instructions
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
