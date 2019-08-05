//
//  MainViewController.swift
//  Recipes
//
//  Created by Nathan Hedgeman on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var searchTextField: UITextField!
    let networkClient = RecipesNetworkClient()
    var recipesTableViewController: RecipesTableViewController?
    
    var allRecipes: [Recipe] = [] {
        
        didSet {
            
            filterRecipes() 
            
        }
        
    }
    
    
    var filteredRecipes: [Recipe] = [] {
        
        didSet {
            
            DispatchQueue.main.async {
                self.recipesTableViewController?.recipes = self.filteredRecipes
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (allRecipes, error) in
            
            if let error = error {
                
                NSLog("Error fetching recipes: \(error)")
                
                return
                
            } else {
                
                guard let fetchedRecipes = allRecipes else { return print("No recipes were fetched")}
                
                self.allRecipes = fetchedRecipes
            }
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func search(_ sender: Any) {
        
        searchTextField.resignFirstResponder()
        filterRecipes()
        
    }
    
    func filterRecipes() {
        
        guard let searchTerm = searchTextField.text else {return}
        
        if searchTerm == " " {
            
            filteredRecipes = allRecipes
            
        } else {
            
            filteredRecipes = allRecipes.filter({ $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)})
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        let tableViewController = segue.destination as! RecipesTableViewController
        
        if segue.identifier == "TableViewSegue" {
            
            recipesTableViewController = tableViewController
            
        }
        // Pass the selected object to the new view controller.
    }
    

}
