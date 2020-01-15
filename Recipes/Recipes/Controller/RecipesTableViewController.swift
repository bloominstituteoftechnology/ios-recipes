//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by alfredo on 1/14/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    
    var recipes: [Recipe] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        
        cell.recipeName = recipes[indexPath.row].name
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard segue.identifier == "tableSegue" else { return }
        guard let recipeDetailVC = segue.destination as? RecipeDetailViewController else { return }
        // Pass the selected object to the new view controller.
        let row = tableView.indexPathForSelectedRow?.row
        recipeDetailVC.recipe = recipes[row!]
    }
}
