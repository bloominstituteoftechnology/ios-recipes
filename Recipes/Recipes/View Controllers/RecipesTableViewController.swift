//
//  RecipeTableViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    let mainVC = MainViewController()
    var recipes: [Recipe] = [] {
        didSet {
            
            tableView.reloadData()        }
    }
    
    let reusidentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusidentifier, for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let destination = segue.destination as? RecipeDetailViewController else { return }
        destination.recipe = recipes[indexPath.row]
        
    }
    

}
