//
//  MainViewController.swift
//  Recipes
//
//  Created by Mitchell Budge on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipe, NSLog("Error loading recipes from file: \(error)")) in
            return self.allRecipes
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchTextFieldEdited(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }

    var recipesTableViewController: RecipesTableViewController? {
    }
}
