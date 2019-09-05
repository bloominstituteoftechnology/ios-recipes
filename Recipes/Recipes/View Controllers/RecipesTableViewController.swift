//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Jessie Ann Griffin on 9/3/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    
    // MARK: Properties
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var recipesTableViewController: RecipesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        searchBar.delegate = self
//        searchBar.returnKeyType = UIReturnKeyType.done
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isSearching {
//            return filteredRecipes.count
//        }
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
       // let recipe: Recipe?
        
//        if isSearching {
//            recipe = filteredRecipes[indexPath.row]
//        } else {
//            recipe = recipes[indexPath.row]
//        }
        
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let detailVC = segue.destination as? RecipeDetailViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
                detailVC.recipe = recipes[indexPath.row]
            }
        }
    }
}
