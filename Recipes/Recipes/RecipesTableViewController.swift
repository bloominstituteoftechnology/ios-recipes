//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Casualty on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    private var recipesDetailViewController: RecipeDetailViewController!
    private let reuseIdentifier = "RecipeCell"
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        guard let destination = segue.destination as? RecipeDetailViewController else { return }
        destination.recipe = recipes[indexPath.row]
    }
}
