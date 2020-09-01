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
  private(set) var recipeStorage = RecipeStorage()
  private let searchController = UISearchController(searchResultsController: nil)
  
  private var notFirstTimeLaunched: Bool {
    UserDefaults.standard.bool(forKey: "NotFirstTime")
  }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpSearchController()
    
    if notFirstTimeLaunched {
      recipeStorage.loadPersistent()
      
    } else {
      fetchRecipesFromInternet()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  private var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  private var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  
  private func setUpSearchController() {
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Find recipe"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  private func fetchRecipesFromInternet() {
    networkClient.fetchRecipes { (recipes, error) in
      guard let recipes = recipes else { return }
      self.recipeStorage.recipes = recipes
      self.recipeStorage.pesister.save(recipes)
      UserDefaults.standard.set(true, forKey: "NotFirstTime")
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? recipeStorage.filteredRecipes.count : recipeStorage.recipes.count
  
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let recipe: Recipe
    recipe = isFiltering ? recipeStorage.filteredRecipes[indexPath.row] : recipeStorage.recipes[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
    cell.textLabel?.text = recipe.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let recipe: Recipe
    
    recipe = isFiltering ? recipeStorage.filteredRecipes[indexPath.row] : recipeStorage.recipes[indexPath.row]
    
    let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as! RecipesDetailViewController
    detailViewController.recipe = recipe
    detailViewController.recipeController = recipeStorage
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension RecipesTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    if let searchText = searchController.searchBar.text, !searchText.isEmpty {
      
      recipeStorage.filteredRecipes = recipeStorage.recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    tableView.reloadData()
  }
}
