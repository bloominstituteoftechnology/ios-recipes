//
//  MainViewController.swift
//  Recipes
//
//  Created by Alex Shillingford on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            print("RecipesTableVC didSet Triggered")
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            print("\(filteredRecipes)")
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var textFieldOutlet: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                print("Error loading Recipes: \(error)")
                return
            }
            
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        }
    }
    
    func filterRecipes() {
        if let searchTerm = textFieldOutlet.text, !searchTerm.isEmpty { // If you're working with textFields, you need to always check if they're empty or not
            filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm) }
        } else {
            filteredRecipes = allRecipes
        }
    }
    
    @IBAction func textFieldAction () {
        resignFirstResponder()
        filterRecipes()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "TableViewSegue":
            guard let destinationVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = destinationVC
        default:
            print("Error loading segue")
        }
    }


}
