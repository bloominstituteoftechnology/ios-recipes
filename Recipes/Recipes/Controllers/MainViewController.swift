//
//  MainViewController.swift
//  Recipes
//
//  Created by Karen Rodriguez on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let networkClient = RecipesNetworkClient()
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
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("We boomed in main view: \(error)")
                return
            }
            
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        }

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedTableSegue" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { fatalError("Boom at embed segue") }
            recipesTableViewController = recipesTableVC
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let search = self.textField.text,
                !search.isEmpty else {
                    self.filteredRecipes = self.allRecipes
                    return
            }
            self.filteredRecipes = self.allRecipes.filter { $0.name.contains(search) || $0.instructions.contains(search) }
        }
        
        
    }
    
    
    @IBAction func editingEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
}
