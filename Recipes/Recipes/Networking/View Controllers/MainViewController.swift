//
//  MainViewController.swift
//  Recipes
//
//  Created by Jonalynn Masters on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] { // add a didSet property
        didSet {
            filterRecipes() // call filterRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? { // add a didSet property
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes // set the recipeTableViewController to filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] { // add a didSet property
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes // set the recipesTableViewController's to the filteredRecipes
        }
    }
    
    //MARK: Outlets
    
    @IBOutlet var textField: UITextField!
    
    /* In the `viewDidLoad`, call the `networkClient`'s `fetchRecipes` method. In its completion closure, if there is an error, NSLog it, and return from the function. If there is no error, set the value of `allRecipes` to recipes returned in this completion closure. */
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in // calling 'fetchRecipe' method
            if let error = error {
                NSLog("Error loading recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func searchTextField(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
     
    //MARK: Methods
   
    // this function will take the text from the text field and filter the recipes with it
    func filterRecipes() {
        if let userSearch =
            textField.text, // take the text from the search field
            !userSearch.isEmpty { // unwrap and make sure it isn't empty
            filteredRecipes = allRecipes.filter {$0.name.contains(userSearch) || $0.instructions.contains(userSearch)} // check if the name or instructions contain the search word
        } else {
            filteredRecipes = allRecipes // if not filtered it should return array of all recipes
        }
    }
    
    // MARK: - Navigation

    /* In the `prepare(for segue: ...)`, check for the embed segue's identifier. If it is, set the `recipesTableViewController` variable to the segue's `destination`. You will need to cast the view controller as the correct subclass.*/
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewEmbedSegue" { // set the variable to the segues destination
            recipesTableViewController = segue.destination as? RecipesTableViewController // cast the view controller as the correct subclass
        } else {
            print("Error. Could not load table view controller")
        }
    }
}
