//
//  MainViewController.swift
//  Recipes
//
//  Created by Ryan Murphy on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    private let networkClient = RecipesNetworkClient()
   
    @IBOutlet weak var maintTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error: \(error)")
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
        if segue.identifier == "RecipeSegue"
    }
    

    @IBAction func mainTextFieldDidEnd(_ sender: Any) {
    }
    
}
