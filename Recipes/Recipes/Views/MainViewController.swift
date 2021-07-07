//
//  MainViewController.swift
//  Recipes
//
//  Created by Rick Wolter on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    let networkClient = RecipesNetworkClient()
    var  allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
        recipesTableViewController?.recipes = filteredRecipes
    }
    }
    
    @IBOutlet weak var recipeSearchTextField: UITextField!
    
    @IBAction func searchRecipes(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("\(error)")
            }
            guard let recipes = recipes else {return}
            
            DispatchQueue.main.async {
                self.allRecipes = recipes
            }
        }
        // Do any additional setup after loading the view.
    }
   
   
    func filterRecipes(){
        guard let searchTerm = recipeSearchTextField.text else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
            recipe.name.contains(searchTerm) || recipe.instructions.contains(searchTerm)
        })
    }

   

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipesTableSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    

}
