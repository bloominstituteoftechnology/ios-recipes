//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipeTableViewController? { //this will hold a reference to the embedded table view controller
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                print("Error loading from the internet: \(error.localizedDescription)")
                return //remember when I return I don't have to do an else clause
            }
            
            //have to call dispatchQ because network calls are on the background thread and all things related to UI have to be done on the main thread
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? [] //recipes is what we get back from the network call/data task operation
                print(self.allRecipes)
            }
        }
    }
    
    @IBAction func actionTextField(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    private func filterRecipes(){
        guard let searchTerm = textField.text, !searchTerm.isEmpty else {
            //if there is no search term that means you should display all of the recipes.
            filteredRecipes = allRecipes
            return }
        //if there IS a search term
        let results = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
        filteredRecipes = results
        print("filteredRecipes set in the filterRecipes function: \(filteredRecipes)")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedSegue" {
            //set the recipesTableViewController VARIABLE to the segue's destination. You will need to cast the view controller as the correct subclass.
            recipesTableViewController = (segue.destination as! RecipeTableViewController)
        }
    }
}
