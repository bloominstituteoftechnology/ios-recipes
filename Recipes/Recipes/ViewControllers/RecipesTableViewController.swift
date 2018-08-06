//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Carolyn Lea on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController
{
    var recipe: Recipe?
    var recipes: [Recipe] = []
    {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeNameCell", for: indexPath)
        
        recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe?.name

        return cell
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowDetailView"
        {
            guard let recipeDetailVC = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            
            recipeDetailVC.recipe = recipes[indexPath.row]
            
            
            
        }
    }

}
