//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Andrew Liao on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
            guard let destinationVC = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.recipe = recipes[indexPath.row]
            
        }
    }
    
    var recipes = [Recipe](){
        didSet{
            tableView.reloadData()
        }
    }
}
