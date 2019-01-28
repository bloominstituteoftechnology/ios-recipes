//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] { //WHY ARE WE ADDING THIS ?????? -----------------------------------------------------------------------------------???????
        didSet {
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let recipe = recipes[indexPath.row].name
        cell.textLabel?.text = recipe //WE ARE POPULATINGI THIS RIGHT HERE BECAUSE WE DONT' HAVE A CUSTOM CELL.
        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //if the segues is from the cell, pass the recipe that corresponds with the cell that was tapped
        if segue.identifier == "cellSegue" {
            guard let toDestinationVC = segue.destination as? DetailViewController, let index = tableView.indexPathForSelectedRow else { return }
            let passThisRecipe = recipes[index.row]
            toDestinationVC.recipe = passThisRecipe
        }
    }


}
