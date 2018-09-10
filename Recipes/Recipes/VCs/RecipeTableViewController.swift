//
//  RecipeTableViewController.swift
//  Recipes
//
//  Created by Farhan on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    var recipes: [Recipe] = []{
        didSet{
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        
        if segue.identifier == "DetailVC"{
            guard let destVC = segue.destination as? RecipeDetailViewController else {return}
            guard let index = tableView.indexPathForSelectedRow else {return}
            destVC.recipe = recipes[index.row]
        }
        // Pass the selected object to the new view controller.
        
        
    }
    

}
