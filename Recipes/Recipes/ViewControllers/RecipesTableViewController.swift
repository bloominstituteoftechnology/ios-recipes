//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Chris Gonzales on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

struct cellKeys{
    static let recipeTableCell = "RecipeCell"
}

struct segueKeys{
    static let recipeDetailSegue = "RecipeDetailSegue"
}

class RecipesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var recipes: [Recipe] = []{
        didSet{
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellKeys.recipeTableCell, for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueKeys.recipeDetailSegue{
            guard let recipeDetailVC = segue.destination as? RecipeDetailViewController,
                let indexpath = tableView.indexPathForSelectedRow else { return }
            let passedRecipe = recipes[indexpath.row]
            recipeDetailVC.recipe = passedRecipe
        }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 

}
