//
//  MainViewController.swift
//  Recipes
//
//  Created by Sameera Roussi on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var receipeSearchBar: UISearchBar!
    
    var recipesTableViewController: RecipeDetailViewController?
    
    private let networkClient = RecipesNetworkClient()
    private var allRecipes: [Recipe] = []
    
    
    
    // MARK: - View states
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        receipeSearchBar.delegate = self

        // Fetch the recipes from the network
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error loading recipes \(error)")
                return
            }
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
