//
//  MainViewController.swift
//  Recipes
//
//  Created by Andrew Ruiz on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
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
            
            // Question: How come filteredRecipes didn't autocomplete? Probably a bug.
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            } else {
                guard let allRecipes = allRecipes else { return }
                DispatchQueue.main.async {
                    self.allRecipes = allRecipes
                    print(self.allRecipes)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func filterRecipes() {
        
        // TODO: What does "if there is no search term" mean?
        // Answer: It means !searchText.isEmpty. So there's a difference between an empty text field and a nil text field. And you can apparently use guard let to check for Booleans. That's so weird. Because intuitively I think of nil and empty as being the same. It's not.
        // Source: https://stackoverflow.com/a/37066435/1291940
        guard let searchText = searchTextField.text, !searchText.isEmpty == true
            else {
                filteredRecipes = allRecipes
                return
        }
        
        // TODO: Not sure if correct
        filteredRecipes = allRecipes.filter({ $0.name == searchText || $0.instructions == searchText })
    }
    
    
    @IBAction func textFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTable" {
            guard let tableVC = segue.destination as? RecipesTableViewController else { return }
            
            recipesTableViewController = tableVC
        }
    }
    
}
