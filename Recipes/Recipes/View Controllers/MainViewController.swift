//
//  MainViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes{ (recipes, error) in
            if let error = error {
                NSLog("Error getting students: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
        

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesViewSegue" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    let networkClient = RecipesNetworkClient()
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func sortByUserString(_ sender: Any) {
        
    resignFirstResponder()
        filterRecipes()
        
    }
    
    
    
    func filterRecipes() {
        
        DispatchQueue.main.async {
            if let text = self.textField.text, text != "" {
                
                self.filteredRecipes = self.allRecipes.filter{ recipe in recipe.name.contains(text)}
                
                self.filteredRecipes += self.allRecipes.filter{ recipe in recipe.instructions.contains(text)}
}
            else {
                self.filteredRecipes = self.allRecipes
            }
}
}
}


