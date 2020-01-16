//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Sal Amer on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipiesCell", for: indexPath)

        // Configure the cell...
        guard indexPath.row < recipes.count else { return UITableViewCell()}
        let recipie = recipes[indexPath.row]
        cell.textLabel?.text = recipie.name
        return cell
    }
   

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailViewSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                     // Get the new view controller using segue.destination.
                let recipeDetailVC = segue.destination as? RecipeDetailViewController {
                        // Pass the selected object to the new view controller.
                recipeDetailVC.recipe = recipes[indexPath.row]
            }
        }

    }

}
