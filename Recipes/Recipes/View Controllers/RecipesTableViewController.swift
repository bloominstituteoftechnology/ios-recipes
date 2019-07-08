//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Kat Milton on 7/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var networkClient: RecipesNetworkClient?
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipes = networkClient?.recipes ?? []
   
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return networkClient?.recipes.count ?? recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        // Configure the cell...
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }
    

    
    private func recipeFor(indexPath: IndexPath) -> Recipe {
        if indexPath.section == 0 {
            return networkClient?.recipes[indexPath.row] ?? recipes[indexPath.row]
        } else {
            return networkClient?.recipes[indexPath.row] ?? recipes[indexPath.row]
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowRecipe" {
            guard let recipeDetailVC = segue.destination as? RecipeDetailViewController else { return }
            guard let index = tableView.indexPathForSelectedRow else { return }
            recipeDetailVC.networkClient = networkClient
            recipeDetailVC.recipe = recipeFor(indexPath: index)
            
        }
        
    }
    

}
