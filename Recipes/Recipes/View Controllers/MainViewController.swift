//
//  MainViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes{ (allRecipes, error) in
            if let error = error {
                NSLog("Error getting students: \(error)")
                return
            }
            self.allRecipes = allRecipes ?? []
            
        }

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailViewControllerSegue" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    let networkClient = RecipesNetworkClient()
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
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
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func sortByUserString(_ sender: Any) {
        
    resignFirstResponder()
        filterRecipes()
        
    }
    
    func filterRecipes() {
        
        if textField.text == nil {filteredRecipes = allRecipes}
        else {
            let text = (self.textField?.text)
            guard let greatText = text else {fatalError("Could not get text.")}
            for recipe in self.allRecipes {
                
                self.filteredRecipes += self.allRecipes.filter{ (recipe) -> Bool in recipe.name.contains(Character(greatText) )}
                
                self.filteredRecipes += self.allRecipes.filter{ (recipe) -> Bool in recipe.instructions.contains(Character(greatText))}
                }
        
        
            }
        }
}
