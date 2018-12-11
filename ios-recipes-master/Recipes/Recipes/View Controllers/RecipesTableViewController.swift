//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Jaspal on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // Create recipes variable set to the Recipe type, but as an empty array.
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // counts the amount of objects in the array to provide the amount of sections required, in this case, all the of the recipes provided by the network.
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Set "cell" to the cell on the table and insert the correct identifier.
        // It's typically best to use a string-type variable for the identifier.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // set the recipes array to a variable that will be used in the cell
        let recipe = recipes[indexPath.row]
        
        // update the text in the cell to connect to the recipes array, of the name property.
        cell.textLabel?.text = recipe.name
        
        // return the cell to comply with the function and actually appear.
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Requirements:
        // 1. Check if the segue with the right identifier exists.
        // 2. Set the indexPath to the selected row
        // 3. Set the destination (the detail VC) to the recipes array's corresponding row
        // 4. Complete the destination setup by connecting it to the Recipe model.
        
        if segue.identifier == "ShowDetailView" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Could not originate from source.") }
            
            guard let destination = segue.destination as? RecipeDetailViewController else { fatalError("Could not reach destination.") }
            
            destination.recipe = recipes[indexPath.row]
            
        }
    }

}
