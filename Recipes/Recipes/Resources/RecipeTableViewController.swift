//
//  RecipeTableViewController.swift
//  Recipes
//
//  Created by Diante Lewis-Jolley on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }



        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 0
        }


        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

            // Configure the cell...

            return cell
        }
    }

