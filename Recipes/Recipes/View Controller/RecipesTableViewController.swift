//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Ilgar Ilyasov on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    // MARK: - Properties
    
    var recipes: [Recipe] = [] {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableCell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableCellSegue" {
            guard let destinationVC = segue.destination as? RecipeDetailViewController,
                  let index = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.recipe = recipes[index.row]
        }
    }
}
