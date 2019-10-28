//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jon Bash on 2019-10-28.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

protocol RecipeDetailVCDelegate: MainViewController {
    var allRecipes: [Recipe] { get set }
}

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: RecipeDetailVCDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let recipe = recipe,
            isViewLoaded
            else { return }
        nameLabel.text = recipe.name
        nameField.text = recipe.name
        recipeTextView.text = recipe.instructions
        view.endEditing(true)
    }

    @IBAction func edit(_ sender: UIButton) {
        toggleEditing()
    }
    
    func toggleEditing() {
        if !isEditing {
            isEditing = true
            hideShow(forEditing: true)
        } else {
            guard let newName = nameField.text, !newName.isEmpty,
                let newInstructions = recipeTextView.text, !newInstructions.isEmpty
                else { return }
            
            let alert = UIAlertController(
                title: "Save changes?",
                message: "The saved recipe data will be replaced with your changes. Are you sure you want to continue?",
                preferredStyle: .actionSheet
            )
            alert.addAction(UIAlertAction(
                title: "Cancel", style: .default, handler: nil)
            )
            alert.addAction(UIAlertAction(
                title: "Discard", style: .cancel, handler: discardChanges(_:)))
            alert.addAction(UIAlertAction(
                title: "Save", style: .destructive, handler: saveChanges(_:))
            )
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func saveChanges(_ alertAction: UIAlertAction) {
        guard let newName = nameField.text, !newName.isEmpty,
            let newInstructions = recipeTextView.text, !newInstructions.isEmpty,
            let oldRecipe = recipe
            else { return }
        
        let newRecipe = Recipe(name: newName, instructions: newInstructions)
        recipe = newRecipe
        
        LocalRecipesStoreController.shared.update(oldRecipe, to: newRecipe)
        
        updateViews()
        delegate?.allRecipes = LocalRecipesStoreController.shared.recipes
        hideShow(forEditing: false)
    }
    
    func discardChanges(_ alertAction: UIAlertAction) {
        hideShow(forEditing: false)
        updateViews()
    }
    
    func hideShow(forEditing editing: Bool) {
        isEditing = editing
        nameLabel.isHidden = editing
        nameField.isHidden = !editing
        nameField.isEnabled = true
        recipeTextView.isEditable = editing
        editButton.setTitle(editing ? "Save Changes" : "Edit", for: .normal)
        recipeTextView.backgroundColor = editing ? .secondarySystemBackground : .systemBackground
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
