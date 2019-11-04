//
//  MainViewController.swift
//  Recipes
//
//  Created by Alex Thompson on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var recipeTextField: UITextField!
    
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    func filterRecipes () {
        DispatchQueue.main.async {
            guard let recipeText = self.recipeTextField.text,
                !recipeText.isEmpty else { return self.filteredRecipes = self.allRecipes }
            
            self.filteredRecipes = self.allRecipes.filter({
                $0.name.contains(recipeText) || $0.instructions.contains(recipeText)
            })
        }
    }
    
    
    
    @IBAction func recipeTextFieldTapped(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipe, error) in
            if let error = error {
                NSLog("Error fetching recipes \(error)")
                return
            }
            if let recipe = recipe {
                DispatchQueue.main.async {
                    self.allRecipes = recipe
                    print("\(self.allRecipes)")
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    // MARK: - Navigation
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        
            
        }
        
        
        
        
    }
    

}
