//
//  MainViewController.swift
//  Recipe
//
//  Created by Diante Lewis-Jolley on 5/6/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipeTableViewController?
    var filteredRecipes: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (allRecipe, error) in
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipe ?? []
            }
        }
    }

    func filterRecipe() {
        if let textField = recipeTextField.text, !textField.isEmpty {
            filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
                return recipe.name.lowercased().contains(textField)
            })

        } else {
            filteredRecipes = allRecipes
        }

    }



    @IBAction func textFieldtapped(_ sender: Any) {
        resignFirstResponder()
        filterRecipe()
    }
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ContainerSegue" {
            recipesTableViewController = (segue.destination as! RecipeTableViewController)
        }


    }



    @IBOutlet weak var recipeTextField: UITextField!

}
