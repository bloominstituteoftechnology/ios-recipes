//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Lambda-School-Loaner-11 on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var recipeDetailViewController: RecipeDetailViewController?


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let recipe = recipes[indexPath.row].name
        cell.textLabel?.text = recipe

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            let recipeDetailVC = segue.destination as! RecipeDetailViewController
            
             // Pass the recipe to the corresponding tapped cell
            guard let index = tableView.indexPathForSelectedRow else { return }
            
            let recipe = recipes[index.row]
            recipeDetailVC.recipe = recipe
            
            recipeDetailViewController = recipeDetailVC
        }
    }
}
