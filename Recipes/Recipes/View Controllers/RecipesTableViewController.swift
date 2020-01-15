//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Alexander Supe on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] { didSet { filterRecipes() } }
    var recipes: [Recipe] = [] {
        didSet { DispatchQueue.main.async { self.tableView.reloadData() } }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        networkClient.fetchRecipes {
            if ($1 != nil) {
                print("\(String(describing: $1))")
            } else {
                guard let newRecipes = $0 else { return }
                self.allRecipes = newRecipes
            }
        }
    }
    
    // MARK: - Base Functions
    func filterRecipes() {
        DispatchQueue.main.async {
            if !self.searchBar.text!.isEmpty { self.recipes = self.allRecipes.filter({ $0.name.contains(self.searchBar.text!) || $0.instructions.contains(self.searchBar.text!) }) }
            else { self.recipes = self.allRecipes }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
    
    // MARK: - Search bar delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterRecipes()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterRecipes()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSegue" {
            if let dest = segue.destination as? RecipeDetailViewController {
                dest.recipe = recipes[tableView.indexPathForSelectedRow?.row ?? 0]
            }
        }
    }
    
}
