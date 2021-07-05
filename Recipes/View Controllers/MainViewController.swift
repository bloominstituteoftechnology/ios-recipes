//
//  MainViewController.swift
//  Recipes
//
//  Created by Joseph Rogers on 10/29/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var searchTextfield: UITextField!
    
    //here we are building a "Network Client" which is our struct in the "Networking" folder. Which will act as the place for us to do our API data searching
    let networkClient = RecipesNetworkClient()
    
    //this is a computed variable that is initilized as empty.
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes() // see FilteredRecipes function
        }
    }
    
    //this is a reference variable to the RecipesTableViewController.
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    //A filtered recipe is a array of type recipe that is initilized.
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    //this is the "network" client using its fetch Recipes closure. which is passing into itself a recipes, and an error.
    //we check that the error is equal to error. if so, return an error message failing to load the data.
    //afterwards we return, and then call all the recipes and make it equal to the recipes in the closure. if not, give it an empty value with nil coalescing.
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error Loading data \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    //MARK: Actions
    
    //this causes a function within the textfields capabilties. it causes the keyboard to resign, and then to call the filter recipes function.
    @IBAction func textFieldAction(_ sender: Any) {
        self.searchTextfield.resignFirstResponder()
        filterRecipes()
    }
    
    //we call dispatchQueue to create a computed function in the main thread, and to make is loadable in the backround, or "as the life cycle events continue"
    //were assigning the text within the text field to a value of text, and checking if is empty.
    //if it is, the filtered recipes go through a filter that uses a closure. this filter higher order function checks the recipes in the all recipes array, and sees if it has any of the text from the recipe or the instructions. if not then just return all of the recipes.
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.searchTextfield.text, text != "" {
                self.filteredRecipes = self.allRecipes.filter( {(recipe) in recipe.name.contains(text) || recipe.instructions.contains(text)} )
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedChildSegue" {
            let vc = segue.destination as! RecipesTableViewController
                recipesTableViewController = vc
        }
    }
}
