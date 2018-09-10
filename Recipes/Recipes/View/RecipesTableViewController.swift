//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Dillon McElhinney on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeSegue" {
            let destinationVC = segue.destination as! RecipeDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let recipe = recipes[indexPath.row]
            
            destinationVC.recipe = recipe
        }
    }

}
