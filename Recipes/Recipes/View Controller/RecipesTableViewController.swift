//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Eoin Lavery on 15/01/2020.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    //MARK: - Properties
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        guard indexPath.row < recipes.count else { return UITableViewCell() }
        let recipe = recipes[indexPath.row]

        cell.textLabel?.text = recipe.name
        
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailShowSegue" {
            if let destinationVC = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.recipe = recipes[indexPath.row]
            }
        }
    }

}
