//
//  MainViewController.swift
//  Recipes
//
//  Created by conner on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTF: UISearchBar!
    
    @IBAction func searchAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            guard error == nil else {
                NSLog("Error fetching Recipes: \(error!)")
                return
            }
            
            guard let recipes = recipes else {
                NSLog("Error fetching recipes: array was nil")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes
            }
        }
    }
    
    func filterRecipes() {
        if let search = searchTF.text, !search.isEmpty {
            filteredRecipes = allRecipes.filter {
                $0.name.contains(search) || $0.instructions.contains(search)
            }
        } else {
            filteredRecipes = allRecipes
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
            
        }
    }

}
