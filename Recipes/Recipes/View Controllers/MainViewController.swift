//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_259 on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    
    // MARK: - IBOutlets
    @IBOutlet var recipeTextField: UITextField!
    
    
    // MARK: - IBActions
    @IBAction func recipeTextFieldEdited(_ sender: Any) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let allRecipes = recipes {
                self.allRecipes = allRecipes
            }
            
            if let error = error {
                NSLog("Error fetching recipes data: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            
    }

}
