//
//  MainViewController.swift
//  Recipes
//
//  Created by Ufuk Türközü on 10.02.20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading students: \(error)")
                return
            }
                      
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    @IBAction func search(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let text = searchTF.text, !text.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = self.allRecipes.filter {$0.name.uppercased().contains(text.uppercased()) || $0.instructions.uppercased().contains(text.uppercased())}
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "RecipesSegue" {
            
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
