//
//  MainViewController.swift
//  Recipes
//
//  Created by Mark Gerrior on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Actions
    
    @IBAction func textFieldAction(_ sender: Any) {
    }
    
    // MARK: - Properties
    var allRecipes: [Recipe] = []

    var recipesTableViewController: RecipesTableViewController?
    let networkClient = RecipesNetworkClient()
        
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                NSLog("Error loading recipes: \(error)!")
                return
            }
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "RecipesSegue" {
            print("RecipesSegue called")
            //guard let recipesTVC = segue.destination as? RecipesTableViewController else { return }
        }
    }
}
