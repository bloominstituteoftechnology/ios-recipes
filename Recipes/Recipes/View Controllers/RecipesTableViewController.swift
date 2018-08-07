//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Linh Bouniol on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    // MARK: - Properties
    
//    var recipes: [Recipe] = [] {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    var recipeController: RecipeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultNC = NotificationCenter.default
        
        defaultNC.addObserver(forName: RecipeController.wasUpdatedNotificaiton, object: nil, queue: nil) { (_) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeController?.filteredRecipes.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = recipeController?.filteredRecipes[indexPath.row].name

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetail" {
            let recipeDetailVC = segue.destination as! RecipeDetailViewController
            recipeDetailVC.recipeController = recipeController
            
            // Get indexPath of the recipe cell that is tapped
            guard let indexPath = tableView.indexPathForSelectedRow?.row else { return }
            
            recipeDetailVC.recipe = recipeController?.filteredRecipes[indexPath]
        }
    }
}
