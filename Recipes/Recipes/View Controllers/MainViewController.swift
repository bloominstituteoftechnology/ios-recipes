//
//  MainViewController.swift
//  Recipes
//
//  Created by morse on 10/27/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    struct PropertyKeys {
        static let embedSegue = "TableViewEmbedSegue"
    }
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes(on: "")
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipe array: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                    self.recipesTableViewController?.reloadInputViews()
                }
            }
        }
    }
    
    //    @IBAction func editingEnded(_ sender: Any) {
    //        resignFirstResponder()
    //        filterRecipes()
    //    }
    
    func filterRecipes(on searchTerm: String) {
        
        if searchTerm == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter({
                fuzzySearch(if: searchTerm, isIn: $0.name) ||
                $0.instructions.contains(searchTerm)
                
            })
        }
    }
    
    func fuzzySearch(if item: String, isIn string: String) -> Bool {
        
        var testString = ""
        var tempItem = item.lowercased()
        var tempString = string.lowercased()
        
        if item.isEmpty {
            return false
        }
        
        while tempString.count >= 1 && tempItem.count >= 1 {
            var checkLetter = tempItem.remove(at: tempItem.startIndex)
            
            for _ in 1...tempString.count {
                let letter = tempString.remove(at: string.startIndex)
                if letter == checkLetter {
                    testString.append(letter)
                    if testString == item.lowercased() {
                        return true
                    }
                    checkLetter = tempItem.remove(at: tempItem.startIndex)
                }
            }
        }
        return item == testString
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.embedSegue {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        filterRecipes(on: searchText)
    }
    
    
}
