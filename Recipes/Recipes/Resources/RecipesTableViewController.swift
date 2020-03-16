//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_241 on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    // Mark:- IBOutlets/Properties
    var recipes: [Recipe] = [] {
        didSet {
            self.tableView.reloadData()
            }
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        

        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetailViewSegue" {
            guard let recipeDetailVC = segue.destination as? RecipeDetailViewController else { return }
            
            let reci = recipes[tableView.indexPathForSelectedRow!.row]

            
            recipeDetailVC.recipe = reci
            
           
            
            
            
            
         
         
    }
    }
    

    
}
