//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Sameera Roussi on 5/6/19.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTitleCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let destinationVC = segue.destination as? RecipeDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow
         else { return }
        
        destinationVC.recipe = recipes[indexPath.row]
   
    }

}

