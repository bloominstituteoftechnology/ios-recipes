//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_204 on 10/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var recipeSearchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion: { recipes, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        })
    }
    
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }

    // MARK: - Class Functions
    
    private func filterRecipes() {
        DispatchQueue.main.async {
            guard let recipeSearchText = self.recipeSearchTextField.text,
                !recipeSearchText.isEmpty else { return self.filteredRecipes = self.allRecipes }
            
            self.filteredRecipes = self.allRecipes.filter({
                $0.name.contains(recipeSearchText) || $0.instructions.contains(recipeSearchText)
            })
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "RecipeEmbedSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    

}
