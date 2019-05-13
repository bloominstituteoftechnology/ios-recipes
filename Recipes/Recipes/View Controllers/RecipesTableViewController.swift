//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Mitchell Budge on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    var recipes: [Recipe] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    } // end of view did load

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    } // end of number of rows

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    } // end of cell for row at

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipeDetailViewController else { return }
        if let cell = sender as? UITableViewCell {
            guard let indexpath = tableView.indexPath(for: cell) else { return }
            destination.recipe = recipes[indexpath.row]
        }
    } // end of prepare for segue
}
