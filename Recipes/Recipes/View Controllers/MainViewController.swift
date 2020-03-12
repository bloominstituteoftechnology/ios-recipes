//
//  MainViewController.swift
//  Recipes
//
//  Created by David Williams on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
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
    
    @IBOutlet weak var searchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        networkClient.fetchRecipes { (recipes, error) in
            guard error.self == nil else {
                NSLog("\(String(describing: error))")
                return 
            }
            guard let recipes = recipes else { return }
            DispatchQueue.main.async {
                   self.allRecipes = recipes
            }
        }
    }
    
    func filterRecipes() {
        guard let searchWords = searchBar.text,
            !searchWords.isEmpty
            else {
                filteredRecipes = allRecipes
                return }
//        filteredRecipes = allRecipes.filter { $0.name.contains(searchWords.capitalized) || $0.name.contains(searchWords.lowercased()) || $0.instructions.contains(searchWords.capitalized) || $0.instructions.contains(searchWords.lowercased())
        filteredRecipes = allRecipes.filter { (recipe: Recipe) -> Bool in
            return (recipe.name.range(of: searchWords, options: .caseInsensitive, range: nil, locale: nil) != nil) || (recipe.instructions.range(of: searchWords, options: .caseInsensitive, range: nil, locale: nil) != nil)
        }
   }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableView" {
        guard let embedVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = embedVC
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    }

    @IBAction func searchBarEdited(_ sender: Any) {
        searchBar.resignFirstResponder()
        filterRecipes()
    }
}
