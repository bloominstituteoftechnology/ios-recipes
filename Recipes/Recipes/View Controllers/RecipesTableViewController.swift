//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Ciara Beitel on 9/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        let aRecipe = recipes[indexPath.row]
        cell.textLabel?.text = aRecipe.name

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetailSegue" {
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let selectedRecipe = recipes[selectedIndexPath.row]
            let recipeDetailVC = segue.destination as! RecipeDetailViewController
            recipeDetailVC.recipe = selectedRecipe
        }
    }
}
