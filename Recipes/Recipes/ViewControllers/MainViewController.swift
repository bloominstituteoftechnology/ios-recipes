//
//  MainViewController.swift
//  Recipes
//
//  Created by Bhawnish Kumar on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
  
      
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var viewTable: UIView!
    
    
    
     let networkClient = RecipesNetworkClient()
    
    private var recipesTableViewController: RecipesTableViewController? {
          didSet {
              recipesTableViewController?.recipes = filteredRecipes
          }
      }
    private var filteredRecipes: [Recipe] = [] {
          didSet {
              recipesTableViewController?.recipes = filteredRecipes
          }
      }
      private var allRecipes: [Recipe] = [] {
          didSet {
              filterRecipes()
          }
      }
     private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error load students: \(error)")
                return
            }
          
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
                self.refreshControl.endRefreshing()
            }

        
        }
        filterRecipes()
        
    
        
    }
    
    
        func filterRecipes() {
           guard let searchTerm = searchTextField.text, !searchTerm.isEmpty else {
              filteredRecipes = allRecipes
               return }
           filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)}
            self.filteredRecipes = allRecipes
       }
    
    @IBAction func searchAction(_ sender: Any) {
    resignFirstResponder()
        filterRecipes()
    }
    
   
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "RecipeSegue" {
               recipesTableViewController = (segue.destination as! RecipesTableViewController)
        
           }
       }
    
}


    

    
