//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
 
  var recipes = [Recipe]() { didSet { tableView.reloadData() }  }
 
  //MARK:- View Life Cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  //MARK: - TableView Datasource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = recipes[indexPath.row].name
    
    return cell
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "CellSegue" {
      if let destVC = segue.destination as? RecipesDetailViewController {
        if let index = tableView.indexPathForSelectedRow {
          destVC.recipe = recipes[index.row]
          destVC.delegate = self
        }
      }
    }
  }
}
extension RecipesTableViewController : RecipesDetailVCDelegate {
  func didReceivedNewRecipes(recipe: Recipe) {
    guard let index = tableView.indexPathForSelectedRow else { return }
    recipes.remove(at: index.row)
    recipes.insert(recipe, at: 0)
    tableView.reloadData()
  }
}
