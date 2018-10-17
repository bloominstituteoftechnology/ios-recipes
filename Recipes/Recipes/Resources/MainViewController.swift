//
//  MainViewController.swift
//  Recipes
//
//  Created by Yvette Zhukovsky on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var filteredRecipes: [Recipe] = []
    
    
    
    
    var allRecipes: [Recipe] = []
    
    
    
    var recipesTableViewController: RecipesTableViewController?
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "recipes") {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("some error\(error)")
                return
            } else {
                if let recs = recipes {
                    self.allRecipes = recs
                }
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func editingDidEnd(_ sender: Any) {
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
