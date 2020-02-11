//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableVC: UITableViewController , RecipesDetailVCDelegate
{
    func didReceivedNewRecipes(name: String, instruction: String) {
    
        let index = tableView.indexPathForSelectedRow
        recipes[index?.row ?? 0].name = name
        recipes[index?.row ?? 0].instructions = instruction
       
        tableView.reloadData()
    }
 
    var recipes : [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    //MARK: - TableView Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            if let destVC = segue.destination as? RecipesDetailVC {
                if   let index = tableView.indexPathForSelectedRow {
                    destVC.recipe = recipes[index.row]
                    destVC.delegate = self
                }
            }
        }
    }
    
    
    
    
    
}
