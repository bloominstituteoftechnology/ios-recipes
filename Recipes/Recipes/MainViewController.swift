//  MainViewController.swift
//  Recipes
//
//  Created by Vijay Das on 12/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var recipesTableViewController: RecipesTableViewController!
    
    var allRecipes: [Recipe] = []
    
    private let networkClient = RecipesNetworkClient()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func edittingDidEnd(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("error fetching recipes: \(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }
        
    }
    
    var filteredRecipes: [Recipe] = []
    
    func filterRecipes() {
        DispatchQueue.main.async {
            
            guard let activeSearchTerm = self.textField.text else { return
            self.filteredRecipes = self.allRecipes
                if activeSearchTerm.isEmpty else { return }
                
            }
    }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbeddedTableView" {
                let recipesTVC = segue.destination as! RecipesTableViewController
                recipesTableViewController = recipesTVC
            }

        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }



}

