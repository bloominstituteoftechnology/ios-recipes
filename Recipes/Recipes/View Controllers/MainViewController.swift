//
//  MainViewController.swift
//  Recipes
//
//  Created by Vijay Das on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
    var recipesTableViewController: RecipesTableViewController?
    
    
    @IBAction func searchCompleted(_ sender: UITextField) {
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }
        

        // Do any additional setup after loading the view.
    }
    

 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tableViewSegue" {
            
            let recipiesTVC = segue.destination as! RecipesTableViewController
            
            recipesTableViewController = recipiesTVC
        }
        



    }
 
}
