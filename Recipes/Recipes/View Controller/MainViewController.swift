//
//  MainViewController.swift
//  Recipes
//
//  Created by Hayden Hastings on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipies = recipes ?? []
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRecipies" {
            recipiesTableViewController = segue.destination as? RecipiesTableViewController
        }
    }
 
    @IBAction func recipieSearch(_ sender: Any) {
        resignFirstResponder()
        filterRecipies()
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    func filterRecipies() {
        guard let searchTerm = searchTextField.text?.lowercased(), !searchTerm.isEmpty else {
            filteredRecipies = allRecipies
            return }
        let searchRecipes = allRecipies.filter ( { $0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm) } )
        filteredRecipies = searchRecipes
        return
    }
    
    var filteredRecipies: [Recipe] = [] {
        didSet {
            recipiesTableViewController?.recipes = filteredRecipies
        }
    }
    var allRecipies: [Recipe] = [] {
        didSet {
            filterRecipies()
        }
    }
    var recipiesTableViewController: RecipiesTableViewController? {
        didSet {
            recipiesTableViewController?.recipes = filteredRecipies
        }
    }
    let networkClient = RecipesNetworkClient()
}
