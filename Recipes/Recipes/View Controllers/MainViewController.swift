//
//  MainViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/4/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    
    let networkClient = RecipesNetworkClient()
    var recipesTableViewController: RecipesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //updateViews()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    

    @IBOutlet weak var mainViewTextField: UITextField!
    @IBAction func mainViewTextAction(_ sender: Any) {

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EmbedRecipesTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
}
