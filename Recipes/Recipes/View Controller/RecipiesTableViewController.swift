//
//  RecipiesTableViewController.swift
//  Recipes
//
//  Created by Hayden Hastings on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipiesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipiesCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        
        cell.textLabel?.text = recipe.name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVC" {
            guard let toDetailVC = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            toDetailVC.recipe = recipes[indexPath.row]
        }
    }

    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
}
