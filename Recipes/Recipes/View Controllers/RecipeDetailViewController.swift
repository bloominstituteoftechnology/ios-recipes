//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by De MicheliStefano on 06.08.18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

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
        guard let networkClient = networkClient,
            let recipe = recipe,
            let recipeBodyText = recipeBodyTextView.text else { return }
        networkClient.updateRecipes(for: recipe, instructions: recipeBodyText)
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
    
    
    
    @IBOutlet weak var recipeTitleTextLabel: UILabel!
    @IBOutlet weak var recipeBodyTextView: UITextView!
    
    var networkClient: RecipesNetworkClient?
}
