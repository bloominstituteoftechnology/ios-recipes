//
//  MainViewController.swift
//  Recipes
//
//  Created by Dillon P on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchFoodsTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("\(error)")
                return
            }
            guard let recipes = recipes else { return }
            self.allRecipes = recipes
        }
        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipesTableViewControllerSegue" {
            guard let recipeTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTableVC
        }
    }
    
    @IBAction func searchFoods(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let searchTerm = searchFoodsTextField.text else { return }
        if searchTerm.isEmpty {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { (searchTerm) -> Bool in
                return true
            }
        }
    }
    

}
