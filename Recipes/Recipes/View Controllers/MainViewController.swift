//
//  MainViewController.swift
//  Recipes
//
//  Created by Kat Milton on 7/8/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    
    var networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
            saveRecipes(recipes: self.allRecipes)
            
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
            networkClient.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
            networkClient.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { allRecipes, error in
            
            if let error = error {
                let errorText: () = NSLog("Error fetching recipes: \(error)")
                return errorText
            }
            
            DispatchQueue.main.async {
                
                self.allRecipes = allRecipes ?? []
                
            }
            
            
            
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func searchTextEdited(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    func filterRecipes() {
        guard let searchTerm = searchTextField.text else { return }
        
        if searchTerm == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
        }
        
    }
    
    func saveRecipes(recipes: [Recipe]) {
        networkClient.recipes = recipes
        networkClient.saveToPersistentStore()
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "RecipeTableSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
            
                    }
    }
    

}
