//
//  MainViewController.swift
//  Recipes
//
//  Created by Joel Groomer on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var txtFilter: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] { didSet { filterRecipes() } }
    var filteredRecipes: [Recipe] = [] { didSet { recipesTableViewController?.recipes = filteredRecipes } }
    var recipesTableViewController: RecipesTableViewController? { didSet { recipesTableViewController?.recipes = filteredRecipes } }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
            } else {
                self.allRecipes = recipes ?? []
            }
        }
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEmbedTableView" {
            if let vc = segue.destination as? RecipesTableViewController {
                recipesTableViewController = vc
            }
        }
    }
    
    func filterRecipes() {
        guard let filter = txtFilter.text, !filter.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter({ $0.name.contains(filter) || $0.instructions.contains(filter) })
    }


    @IBAction func filterEditingDidEnd(_ sender: Any) {
        txtFilter.resignFirstResponder()
        filterRecipes()
    }
}
