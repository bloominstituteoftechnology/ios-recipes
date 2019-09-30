//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Jonalynn Masters on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    //MARK: Properties
     var recipes: [Recipe] = [] { // add a variable with a 'didSet' property observer that reloads the table view
        didSet {
            tableView.reloadData() // this reloads the table view
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count //return the number of rows = the number of recipes
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name // display the name of its corresponding Recipe object
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
      
    /* In the `prepare(for segue: ...)`, check the segue's identifier. If the segue is going to the `RecipeDetailViewController` and triggered by tapping a cell on this table view controller, pass the `Recipe` that corresponds with the cell that was tapped. */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" { // check identifier
            let detailVC = segue.destination as! RecipeDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            guard let selectedIndexPath = indexPath else { return }
            detailVC.recipe = self.recipes[selectedIndexPath.row]
        } else {
            print("Error. Could not find recipe")
        }
    }
}
