//
//  MainViewController.swift
//  Recipes
//
//  Created by Isaac Lyons on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
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
            } else if let recipes = recipes {
                self.allRecipes = recipes
            }
        }
    }
    
    func filterRecipes() {
        guard let search = textField.text,
            search != "" else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
            if let _ = recipe.name.range(of: search, options: .caseInsensitive) {
                return true
            } else if let _ = recipe.instructions.range(of: search, options: .caseInsensitive) {
                return true
            } else {
                return false
            }
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipesTableViewEmbedSegue" {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }

    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
}
