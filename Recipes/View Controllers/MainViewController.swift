//
//  MainViewController.swift
//  Recipes
//
//  Created by Welinkton on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes:[Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filterdRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filterdRecipes
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let search = self.searchTextField.text else {return}
            
            if search == "" {
                self.filterdRecipes = self.allRecipes
            }else{
                self.filterdRecipes = self.allRecipes.filter {$0.name.lowercased().contains(search) || $0.instructions.lowercased().contains(search)}
            }
        }
        
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            
            if let error = error {
                NSLog("error getting recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                 self.allRecipes = recipes ?? []
            }
           
            
        }
        
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func DidEndonExit(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet{
            recipesTableViewController?.recipes = filterdRecipes
        }
    }
    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
           
        }
    }
}
