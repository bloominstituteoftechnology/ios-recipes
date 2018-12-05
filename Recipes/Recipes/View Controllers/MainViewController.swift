//
//  MainViewController.swift
//  Recipes
//
//  Created by Ivan Caldwell on 12/4/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []  {
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
    
    @IBOutlet weak var mainViewTextField: UITextField!
    
    @IBAction func mainVewTextAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    //    @IBAction func mainViewTextAction(_ sender: Any) {
//        resignFirstResponder()
//        filterRecipes()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
        //self.recipesTableViewController?.tableView.reloadData()
    }
    
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.mainViewTextField.text, !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            self.filteredRecipes = self.allRecipes.filter({ $0.name.lowercased().contains(text.lowercased()) || $0.instructions.lowercased().contains(text.lowercased()) })
            
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
}
