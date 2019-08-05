//
//  RecipeTableVC.swift
//  Recipes
//
//  Created by Jeffrey Santana on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableVC: UITableViewController {

	@IBOutlet weak var searchTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
	}
}
