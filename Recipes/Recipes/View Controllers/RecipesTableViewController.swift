//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Sergey Osipyan on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    private var recipeDatailViewController: RecipeDatailViewController!
    
   var  recipes: [Recipe] = [] {
    didSet {
        DispatchQueue.main.async {
            
    self.tableView.reloadData()
        }
    }
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? RecipeDatailViewController else {return}
        if let cell = sender as? UITableViewCell {
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            destination.recipe = recipes[indexPath.row]
        
        
            
}
}
}
