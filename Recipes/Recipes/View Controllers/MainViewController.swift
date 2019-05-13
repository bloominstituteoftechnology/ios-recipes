//
//  MainViewController.swift
//  Recipes
//
//  Created by Jeremy Taylor on 5/12/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.filterRecipes()
            }
            
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
            }
            
            guard let recipes = recipes else { return }
            self.allRecipes = recipes
        }
    }
    
    func filterRecipes() {
        if let text = searchTextField.text, text != "" {
            let results = allRecipes.filter {$0.name.contains(text) || $0.instructions.contains(text)}
            filteredRecipes = results
        } else {
            filteredRecipes = allRecipes
        }
    }
    
    @IBAction func searchFinished(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableViewController" {
           recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
}
