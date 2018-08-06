//
//  MainViewController.swift
//  Recipes
//
//  Created by Carolyn Lea on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    @IBOutlet weak var searchTextField: UITextField!
    var recipesTableViewController: RecipesTableViewController?
    {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = []
    {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error
            {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }

    func filterRecipes()
    {
        DispatchQueue.main.async {
            guard let searchTerm = self.searchTextField.text else {return}
            if searchTerm == ""
            {
                self.filteredRecipes = self.allRecipes
            }
            else
            {
                self.filteredRecipes = self.allRecipes.filter { $0.name == searchTerm }
            }
            
            
        }
        
    }
    
    @IBAction func search(_ sender: Any)
    {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "EmbedRecipeTableView"
        {
            let recipeTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipeTableVC
        }
    }
    

}
