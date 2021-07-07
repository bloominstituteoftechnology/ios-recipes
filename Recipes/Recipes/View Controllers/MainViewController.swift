//
//  MainViewController.swift
//  Recipes
//
//  Created by Ryan Murphy on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    private var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    private let networkClient = RecipesNetworkClient()
   
    @IBOutlet weak var maintTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            } else {
                guard let recipes = recipes else { return }
                self.allRecipes = recipes
            }
        }
    }
            
  
    private func filterRecipes() {
        DispatchQueue.main.async {
            guard let search = self.maintTextField.text?.lowercased(), !search.isEmpty
            else {
                self.filteredRecipes = self.allRecipes
                return
        }
            self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().contains(search) || $0.instructions.lowercased().contains(search) }
    }
}


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    
    

    @IBAction func mainTextFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
}
