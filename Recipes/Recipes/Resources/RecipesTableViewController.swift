//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nathanael Youngren on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetails" {
            let recipeDetailVC = segue.destination as! RecipeDetailViewController
            if let selectedCell = selectedCell {
                recipeDetailVC.recipe = recipes[selectedCell.row]
            }
        }
    }
    
    var selectedCell: IndexPath?
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }

}
