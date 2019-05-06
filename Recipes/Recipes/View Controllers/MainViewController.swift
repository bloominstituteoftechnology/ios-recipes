//
//  MainViewController.swift
//  Recipes
//
//  Created by Christopher Aronson on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterText()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.allRecipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }

    @IBOutlet weak var searchTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting data: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableViewController" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
    }
    
    func filterText() {
        print("filteredText()")
        print(allRecipes)
        if let search = searchTextFiled.text {
            filteredRecipes = allRecipes.filter {$0.name == search}
        } else {
            filteredRecipes = allRecipes
        }
        
        recipesTableViewController?.recipes = allRecipes
    }
 

    @IBAction func search(_ sender: Any) {
        resignFirstResponder()
        filterText()
    }
}
