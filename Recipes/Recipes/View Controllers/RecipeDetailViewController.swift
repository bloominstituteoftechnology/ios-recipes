//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by De MicheliStefano on 06.08.18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

protocol RecipeDetailViewControllerDelegate {
    func updateRecipes(recipe: Recipe, instructions: String)
}

class RecipeDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let recipe = recipe,
            let recipeBodyText = recipeBodyTextView.text else { return }
        delegate?.updateRecipes(recipe: recipe, instructions: recipeBodyText)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            recipeTitleTextLabel?.text = recipe.name
            recipeBodyTextView?.text = recipe.instructions
        }
    }
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    var networkClient: RecipesNetworkClient?
    var delegate: RecipesTableViewController?
    
    @IBOutlet weak var recipeTitleTextLabel: UILabel!
    @IBOutlet weak var recipeBodyTextView: UITextView!
    
}
