//
//  MainViewController.swift
//  Recipes
//
//  Created by Iyin Raphael on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipe, error) in
            if let error = error{
                NSLog("Error ocured while fetching data: \(error)")
                return
            }
            if let recipes = recipe{
                self.allRecipes = recipes
            }
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldAction(_ sender: Any) {
        view.endEditing(true)
        resignFirstResponder()
        filterRecipe()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let detialVC = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = detialVC
        }
    }
    func filterRecipe(){
        DispatchQueue.main.async {
            guard let text = self.textField.text, text != "" else {
                self.filteredRecipes = self.allRecipes
                return }
            
            let lookUpRecipies = self.allRecipes.filter({$0.name.contains(text) || $0.instructions.contains(text)})
            self.filteredRecipes = lookUpRecipies
            
        }
    }
    
    
    var filteredRecipes = [Recipe](){
        didSet{
            recipesTableViewController.recipe = self.filteredRecipes
        }
    }
    var allRecipes = [Recipe](){
        didSet{
            filterRecipe()
        }
    }
    let networkClient = RecipesNetworkClient()
    var recipesTableViewController = RecipesTableViewController(){
        didSet{
           recipesTableViewController.recipe = self.filteredRecipes
        }
    }

}
