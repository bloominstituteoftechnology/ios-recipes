//
//  TableViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    private let mainVC = MainViewController()
    private let reuseIdentifier = "cell"
    
    private var recipesDetailViewController: RecipesDetailViewController!

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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        

        return cell
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let destination = segue.destination as? RecipesDetailViewController else { return }
        destination.recipe = recipes[indexPath.row]
        print(recipes[indexPath.row])
    }
}
