//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_259 on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let recipeController = RecipeController.recipeController
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
        return recipeController.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = recipeController.recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = recipeController.recipes[indexPath.row]
            recipeController.deleteRecipe(name: recipe.name)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            recipes.remove(at: indexPath.row)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            guard let detailVC = segue.destination as? RecipeDetailViewController, let index = tableView.indexPathForSelectedRow?.row else { return }
            let recipe = recipeController.recipes[index]
            detailVC.recipe = recipe
        }
    }

}
