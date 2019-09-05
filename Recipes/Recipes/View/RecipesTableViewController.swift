//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Joel Groomer on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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
        if segue.identifier == "segueShowRecipe" {
            if let vc = segue.destination as? RecipeDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                vc.recipe = recipes[indexPath.row]
            }
        }
    }
}
