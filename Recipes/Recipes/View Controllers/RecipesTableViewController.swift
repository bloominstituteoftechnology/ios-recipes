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

	var recipes: [Recipe] = [] {
		didSet { tableView.reloadData() }
	}
	
}
