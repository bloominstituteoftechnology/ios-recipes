//
//  MainViewController.swift
//  Recipes
//
//  Created by Victor  on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
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
    var recipesTableViewController: RecipesTableViewController?
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchText = self.textField.text, searchText != "" else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().contains(searchText) || $0.instructions.lowercased().contains(searchText) }
        }
    }
    
    
    func fetch() {
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                print(error)
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    
    @IBAction func textFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableView" {
            guard let destinationVC = segue.destination as? RecipesTableViewController else {return}
            
            recipesTableViewController = destinationVC
        }
    }
}
