//
//  MainViewController.swift
//  Recipes
//
//  Created by Karen Rodriguez on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

//    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField: UISearchBar!
    
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.allRecipes
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
        textField.delegate = self
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("We boomed in main view: \(error)")
                return
            }
            
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedTableSegue" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { fatalError("Boom at embed segue") }
            recipesTableViewController = recipesTableVC
        }
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            guard !searchText.isEmpty else {
                    self.filteredRecipes = self.allRecipes
                    return
            }
            self.filteredRecipes = self.allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText) }
        }
    }
}
