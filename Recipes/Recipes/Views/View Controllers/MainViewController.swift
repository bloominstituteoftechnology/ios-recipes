//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var recipesTableViewController: RecipesTableViewController? { //Later we will make it hold a reference to the embedded table view controller
        didSet {
            //Just like the didSet in the filteredRecipes, it should set the recipeTableViewcontroller's recipes to the filteredRecipes. Between these two property observers, it will ensure that the talbe view controller has the most current array of recipes whethere filtered or not.
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            //this will be set after the search is executed
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //call the fetchRecipes method. if there is no error set the value of allRecipes to recipes returned in this completion closure. This way the tableView will populate with all recipes returned
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching the recipes from the network call: \(error.localizedDescription)")
            }
            //no errors so set the value of allRecipes to the ones we've gotten back
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes(){ //this will take the text from the textField and filter the recipes with it.
        DispatchQueue.main.async {
            guard let searchTerm = self.textField.text, !searchTerm.isEmpty else {
                //if searchTerm is empty or nil set the value of filteredRecipes to allRecipes
                self.filteredRecipes = self.allRecipes
                return }
            
            let nameSearch = self.allRecipes.filter({ $0.name == searchTerm  || $0.instructions == searchTerm})
            self.filteredRecipes = nameSearch
        }
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "embeddSegue" {
            guard let toDestinationVC = segue.destination as? RecipesTableViewController else { return }
            toDestinationVC.recipes = allRecipes
        }
        
    }


}
