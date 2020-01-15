//
//  MainViewController.swift
//  Recipes
//
//  Created by Alexander Supe on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Base Functions
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.textField.text, text != "" else { self.filteredRecipes = self.allRecipes; return }
            self.filteredRecipes = self.allRecipes.filter({ $0.name.contains(text) || $0.instructions.contains(text) })
        }
    }
    
    @IBAction func textFieldAction(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
}
