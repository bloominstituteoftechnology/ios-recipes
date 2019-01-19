//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nelson Gonzalez on 1/19/19.
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
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? RecipeDetailViewController
            guard let recipeIndex = tableView.indexPathForSelectedRow else {return}
            destinationVC?.recipe = recipes[recipeIndex.row]
        } 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }

}
