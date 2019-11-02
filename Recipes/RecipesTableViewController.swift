//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_201 on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        cell.detailTextLabel?.text = recipe.instructions
        
       
        return cell
    }
    

   

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeDetailsSegue" {
            guard let destinationVC = segue.destination as? RecipeDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.recipe = recipes[indexPath.row]
        }
        
        
    }
    

}


//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//       if segue.identifier == "AddBook" {
//
//           guard let destinationVC = segue.destination as? BookDetailViewController else { return }
//
//           destinationVC.bookController = bookController
//
//       } else if segue.identifier == "ViewBook" {
//           guard let indexPath = tableView.indexPathForSelectedRow,
//               let destinationVC = segue.destination as? BookDetailViewController else { return }
//
//           let book = bookFor(indexPath: indexPath)
//
//           destinationVC.book = book
//           destinationVC.bookController = bookController
//       }
//   }
//
