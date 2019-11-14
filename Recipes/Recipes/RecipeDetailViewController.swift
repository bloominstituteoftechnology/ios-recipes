//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by admin on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateViews() {
        guard let recipe = recipe,
            isViewLoaded else { return }
        
        recipeNameLabel.text = recipe.name
        recipeTextView.text = recipe.instructions
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        // Planet -> Data -> Encode in coder
        
        defer { super.encodeRestorableState(with: coder) }
        
        var recipeData: Data?
        
        do {
            recipeData = try PropertyListEncoder().encode(recipe)
        } catch {
            NSLog("Error encoding planet: \(error)")
        }
        
        guard let recipe = recipeData else { return }
        
        coder.encode(recipe, forKey: "recipeData")
        
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        defer {
            super.decodeRestorableState(with: coder)
        }
        
        // Data -> Planet -> put in planet var -> pdate views
        
        guard let recipeData = coder.decodeObject(forKey: "recipeData") as? Data else { return }
        
        self.recipe = try? PropertyListDecoder().decode(Recipe.self, from: recipeData)
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
