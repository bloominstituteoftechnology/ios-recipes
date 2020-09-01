//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
  
  private let networkClient = RecipesNetworkClient()
  
  let searchController = UISearchController(searchResultsController: nil)
  var recipes: [Recipe] = []
  var filteredRecipes: [Recipe] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Find recipe"
    navigationItem.searchController = searchController
    
    definesPresentationContext = true
    
    fetchRecipes()
    
  }
  
  private var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  private var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  
  private func fetchRecipes() {
    networkClient.fetchRecipes { (recipes, error) in
      guard let recipes = recipes else { return }
      self.recipes = recipes
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      return filteredRecipes.count
    }
    return recipes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let recipe: Recipe
    recipe = isFiltering ? filteredRecipes[indexPath.row] : recipes[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecipCell", for: indexPath)
    cell.textLabel?.text = recipe.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let recipe: Recipe
    
    recipe = isFiltering ? filteredRecipes[indexPath.row] : recipes[indexPath.row]
   
    let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as! RecipesDetailViewController
    detailViewController.recipe = recipe
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension RecipesTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    if let searchText = searchController.searchBar.text, !searchText.isEmpty {
      
      filteredRecipes = recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    tableView.reloadData()
  }
}
