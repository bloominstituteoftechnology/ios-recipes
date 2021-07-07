//
//  MainViewController.swift
//  Recipes
//
//  Created by Alex Shillingford on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
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
                NSLog(error.localizedDescription)
            }
            
            if let recipes = recipes {
                self.allRecipes = recipes
            }
            
            return
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.textField.text,
                !searchTerm.isEmpty else {
                    self.filteredRecipes = self.allRecipes
                    return
            }
            
            if searchTerm.isEmpty {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains(searchTerm.lowercased()) || $0.instructions.contains(searchTerm.lowercased()) }
            }
        }
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "TableViewSegue" {
            guard let tableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = tableVC
        }
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func textFieldSearch(_ sender: UITextField) {
        sender.resignFirstResponder()
        filterRecipes()
    }
    
    

}
