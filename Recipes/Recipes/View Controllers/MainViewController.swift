//
//  MainViewController.swift
//  Recipes
//
//  Created by Ciara Beitel on 9/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
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
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func search(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            guard let recipes = recipes else { return }
            self.allRecipes = recipes
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableViewSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
    
    func filterRecipes() {

        //unwrap search term, make sure not empty string, if search term is empty or nil set filteredRecipes = allRecipes
        if (searchTextField.text == "") || (searchTextField == nil)  {
            filteredRecipes = allRecipes
        } else {
            guard let searchText = searchTextField.text else { return }
            filteredRecipes = allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText) }
        }
    }
}
