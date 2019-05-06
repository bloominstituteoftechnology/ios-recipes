//
//  MainViewController.swift
//  Recipes
//
//  Created by Lisa Sampson on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    private let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    // MARK: - View Loading Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loadign recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    // MARK: - Filter Methods
    
    @IBAction func filter(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let search = self.textField.text, search.count > 0 {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.contains(search) || recipe.instructions.contains(search)
                })
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
}
