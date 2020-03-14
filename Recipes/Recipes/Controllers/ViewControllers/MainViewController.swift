//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_loaner_226 on 3/14/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let networkClient = RecipesNetworkClient()
    
    private var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var mainTextField: UITextField!
    @IBAction func mainTextFieldUsed(_ sender: UITextField) {
        sender.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    //MARK: - Helper Methods
    private func filterRecipes() {
        guard let searchTerm = mainTextField.text, !searchTerm.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter {
            $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbeddedMainTVCSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
    
}
