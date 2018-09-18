//
//  MainViewController.swift
//  Recipes
//
//  Created by Scott Bennett on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet {
            filterRceipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error retrieving receipes \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
            
        }
    }
    
    
    @IBAction func searchTextField(_ sender: Any) {
        resignFirstResponder()
        filterRceipes()

    }
    
    func filterRceipes() {
            guard let searchTerm = mainTextField.text else { return }
            if searchTerm == "" {
                filteredRecipes = allRecipes
            } else {
                filteredRecipes = allRecipes.filter({ $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) })
            }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }

}
