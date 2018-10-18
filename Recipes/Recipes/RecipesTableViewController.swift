//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    
    
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
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

       cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
  

   

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let destinationVC = segue.destination as? RecipeDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC?.recipe = recipes[indexPath.row]
        }

    }


}
