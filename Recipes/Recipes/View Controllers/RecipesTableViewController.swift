//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/4/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    private var recipeDetailViewController: RecipeDetailViewController!
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
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailViewSegue" {
//            let recipesDetailVC = segue.destination as! RecipeDetailViewController
//            recipeDetailViewController = recipesDetailVC
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipeDetailViewController else {return}
        if let cell = sender as? UITableViewCell {
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            destination.recipe = recipes[indexPath.row]
        }
    }

}
