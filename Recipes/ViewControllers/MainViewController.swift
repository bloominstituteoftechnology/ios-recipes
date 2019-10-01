//
//  MainViewController.swift
//  Recipes
//
//  Created by macbook on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: - Properties
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            guard let recipes = recipesTableViewController?.recipes else { return }
            filteredRecipes = recipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            guard let recipes = recipesTableViewController?.recipes else { return }
            filteredRecipes = recipes
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error while loggin \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
    }
    
    //MARK: - Outlet
    @IBAction func searchTextFieldAction(_ sender: UITextField) {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    
    func filterRecipes() {
        if let recipe = searchTextField.text,
            !recipe.isEmpty {
            filteredRecipes = allRecipes.filter({ $0.name == recipe })
            
        }
            
            else {
                filteredRecipes = allRecipes
                return
                
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewEmbeded" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
            
        }
    }
    

}
