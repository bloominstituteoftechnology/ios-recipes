//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nathan Hedgeman on 7/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    //Properties
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var recipesTableViewController = RecipesTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath)
        
        // Configure the cell...
        cell.detailTextLabel?.text = recipes[indexPath.row].name
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let detailedVC = segue.destination as? RecipesDetailedViewController else {return}
        
        // Pass the selected object to the new view controller.
        if segue.identifier == "RecipesCellSegue" {
            
            guard let selection = tableView.indexPathForSelectedRow?.row else {return}
            
            detailedVC.recipe = recipes[selection].self
        }
    }
   

}
