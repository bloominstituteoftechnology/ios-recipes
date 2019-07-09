//
//  MainViewController.swift
//  Recipes
//
//  Created by Nathan Hedgeman on 7/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //Propeties
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Problem getting recipes: \(error)")
                return
            } else {
                guard let recipes = recipes else {return}
                self.allRecipes = recipes
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var searchBar: UITextField!
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "TableEmbedSegue" {
            
            guard let recipesTV = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = recipesTV
        }
        
    }
    
    //Functions
    
    func filterRecipes() {
        
        if searchBar.text == "" {
            filteredRecipes = allRecipes
        } else {
            let results = allRecipes.filter({ $0.name == searchBar.text})
            filteredRecipes = results
        }
    }
    
    @IBAction func searchBarSearching(_ sender: Any) {
        
        searchBar.resignFirstResponder()
        filterRecipes()
        
    }
    
}
