//
//  MainViewController.swift
//  Recipes
//
//  Created by Bradley Diroff on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchBarTextview: UITextField!
    
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes(completion: { recipes, error in 
            if let error = error {
                NSLog("Error loading students \(error)")
                return
            }
            
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
            })
        
    }
    
    @IBAction func endingEditing(_ sender: Any) {
    }
    
    func filterRecipes() {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tableSegue" {
            guard let vc = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = vc
        }
        
    }
    

}
