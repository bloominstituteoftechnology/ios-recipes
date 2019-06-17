//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    //
    // MARK: - Properties
    //
    
    var recipes: [Recipe] = [] {
        didSet {
           tableView.reloadData()
        }
    }

    //
    // MARK: - View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
            cell.detailTextLabel!.text = recipes[indexPath.row].name
                
            
            
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            case "ShowDetailSegue":
                let detailVC = segue.destination as! RecipeDetailViewController
                let indexPath = tableView.indexPathForSelectedRow!
                detailVC.recipe = self.recipes[indexPath.row]
            default:
                print("error loading segue")
            
        }
    }
    

}
