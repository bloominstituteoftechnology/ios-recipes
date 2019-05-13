//
//  MainViewController.swift
//  Recipes
//
//  Created by Jonathan Ferrer on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    var networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes from server: \(error)")
                return
            } else {
                guard let recipes = recipes else { return }
                self.allRecipes = recipes
            }
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableView" {
            guard let destinationVC = segue.destination as? recipesTableViewController else { return }
        }
    }

    func filterRecipes() {
        guard let searchTextFieldText = searchTextField.text, !searchTextFieldText.isEmpty else  { filteredRecipes = allRecipes }
        filteredRecipes = allRecipes.filter()
    }

    @IBAction func search(_ sender: UITextField) {
    }

    
}
