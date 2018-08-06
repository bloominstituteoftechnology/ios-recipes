//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Andrew Liao on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    func updateViews(){
        guard let recipe = recipe, isViewLoaded else {return}
        titleLabel.text = recipe.name
        textView.text = recipe.instructions
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
  
    @IBAction func save(_ sender: Any) {
        guard let recipe = recipe,
        let instructions = textView.text else {return}
        
        mainViewController?.update(recipe: recipe, instructions: instructions)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Properties
    var recipe:Recipe?{
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var mainViewController: MainViewController?
}
