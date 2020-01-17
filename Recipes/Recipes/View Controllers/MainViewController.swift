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
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    
    @IBOutlet weak var searchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipe, error) in
            guard error.self == nil else {
                NSLog("\(String(describing: error))")
                return 
            }
            guard let recipe = recipe else { return }
            self.allRecipes = recipe
        }
    }
    
    func filterRecipes() {
        guard let searchWords = searchBar.text else {
            return filteredRecipes = allRecipes
        }
        filteredRecipes = allRecipes.filter { (recipe: Recipe) -> Bool in
            return recipe.name.range(of: searchWords, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func recipeTapped(_ sender: Any) {
        searchBar.resignFirstResponder()
        filterRecipes()
    }
}
