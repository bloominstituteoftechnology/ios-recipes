//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Kat Milton on 7/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet var recipeNameLabel: UILabel!
    @IBOutlet var recipeInstructions: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    var networkClient: RecipesNetworkClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editRecipeInstructions))
        self.navigationItem.rightBarButtonItem = save
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews() {
        guard isViewLoaded == true ,
            let recipe = recipe else { return }
        
        recipeNameLabel.text = recipe.name
        recipeInstructions.text = recipe.instructions
    }
    
    @objc func editRecipeInstructions() {
        guard let recipe = recipe else { return }
        print("Editing text")
        networkClient?.updateRecipe(recipe: recipe, name: recipe.name, instructions: recipeInstructions.text)
        navigationController?.popViewController(animated: true)
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
