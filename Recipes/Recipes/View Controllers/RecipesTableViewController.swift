//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Cameron Dunn on 1/22/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    
    var recipes: [Recipe] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CellTappedSegue"){
            let newSender = sender as! UITableViewCell
            let recipeDetailVC = RecipeDetailViewController()
            let indexPath = tableView.indexPath(for: newSender)
            recipeDetailVC.recipe = recipes[indexPath!.row]
            
        }
    }

   
}
