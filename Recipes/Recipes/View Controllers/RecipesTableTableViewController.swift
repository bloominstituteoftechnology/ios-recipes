//
//  RecipesTableTableViewController.swift
//  Recipes
//
//  Created by Audrey Welch on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableTableViewController: UITableViewController {

    var recipe: Recipe?
    
    private var recipes: [Recipe] = [] {
        
        // Whenever the property changes, call the reloadData function
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return recipes.count
    }

    
    // Contents of cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        // Put the name in the cell
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
    
    
    // Reference so that the Detail View Controller has access to the Detail Table View Controller
    private var recipeDetailTableViewController: RecipeDetailViewController!
    
    
    // Prepare for segue from Table View Controller to Detail View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a property that references the Detail View Controler
        if segue.identifier == "ShowDetailView"  {
            
            // fetch index path and view controller
            guard
                let destination = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            // Pass the recipe from the recipes array that corresponds with the indexPath (cell that was tapped)
            let recipe = recipes[indexPath.row]
            destination.recipe = recipe
            
            /* I think this should be the segue from the Main View Controller to the Recipes Table View Controller
             // Get the new view controller using segue.destination
             let recipeDetailTableVC = segue.destination as! RecipeDetailViewController
             
             // Pass the selected object to the new view controller
             recipeDetailTableViewController = recipeDetailTableVC
             */
 
        }
    }
    



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation


    */

}
