//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Hector Steven on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
	
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
		cell.textLabel?.text = "\(indexPath.row)"
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "TableViewCellSegue" {
			guard let vc = segue.destination as? RecipeDetailViewController else { return }
			guard let cell = sender as? UITableViewCell,
				let indexPath = tableView.indexPath(for: cell)  else { return }
			vc.recipe = recipes[indexPath.row]
		}
	}
	
	

	var recipes: [Recipe] = [] {
		didSet { tableView.reloadData() }
	}
	
}
