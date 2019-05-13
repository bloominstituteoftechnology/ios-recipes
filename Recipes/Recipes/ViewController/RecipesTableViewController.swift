//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Taylor Lyles on 5/13/19.
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

    }

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
        return recipes.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
		
		cell.textLabel?.text = recipes[indexPath.row].name
		
		return cell
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "CellSegue" {
			guard let destinationVC = segue.destination as? RecipeDetailViewController else { return }
		
		guard let index = tableView.indexPathForSelectedRow?.row else { return }
		destinationVC.recipe = recipes[index]
		
		}
	}

}
