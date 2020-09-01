//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
 
  let networkClient = RecipesNetworkClient()
  
  var recipes: [Recipe] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    networkClient.fetchRecipes { (recipes, error) in
      guard let recipes = recipes else { return }
      self.recipes = recipes
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let recipe = recipes[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecipCell", for: indexPath)
    cell.textLabel?.text = recipe.name
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let recipe = recipes[indexPath.row]
    let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as! RecipesDetailViewController
    detailViewController.recipe = recipe
    navigationController?.pushViewController(detailViewController, animated: true)
  }
}
