//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Conner on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetailSegue" {
            let recipesDetailVC = segue.destination as! RecipeDetailViewController
            if let tappedOnRecipe = sender as? Recipe {
                recipesDetailVC.recipe = tappedOnRecipe
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        performSegue(withIdentifier: "ShowRecipeDetailSegue", sender: recipe)
    }
}
