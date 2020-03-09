//
//  MainViewController.swift
//  Recipes
//
//  Created by Wyatt Harrell on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
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
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading students: \(error)")
                return
            }
            
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    func filterRecipes() {
        guard let search = searchTextField.text, !search.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter { $0.name.contains(search) || $0.instructions.contains(search) }
    }
    
    @IBAction func senderresignFirstResponderdidEndEditing(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    

}
