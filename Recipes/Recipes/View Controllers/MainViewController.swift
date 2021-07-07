//
//  MainViewController.swift
//  Recipes
//
//  Created by Nelson Gonzalez on 1/19/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
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
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipe, error) in
            if error != nil {
                NSLog("Error fetching recipes \(error!.localizedDescription)")
                return
            }
            
            self.allRecipes = recipe ?? []
            
        }
    }
    

    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.searchTextField.text, !searchTerm.isEmpty else {
                self.filteredRecipes = self.allRecipes
            return
        }
        //refactored
//        filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
//            return recipe.name.contains(searchTerm) || recipe.instructions.contains(searchTerm)
//        })
       
            self.filteredRecipes = self.allRecipes.filter{ $0.name.lowercased().contains(searchTerm.lowercased()) || $0.instructions.lowercased().contains(searchTerm.lowercased())}
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toTableVC" {
            let destinationVC = segue.destination as? RecipesTableViewController
        recipesTableViewController = destinationVC
        }
    }
   
    
    
    @IBAction func searchTextExit(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
}
