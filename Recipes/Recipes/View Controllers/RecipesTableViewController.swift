//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Sergey Osipyan on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    private var recipeDatailViewController: RecipeDatailViewController!
    
   var  recipes: [Recipe] = [] {
    didSet {
    tableView.reloadData()
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
        if segue.identifier == "detail" {
            let recipeTableVC = segue.destination as! RecipeDatailViewController
            recipeDatailViewController = recipeTableVC
}
}
}
