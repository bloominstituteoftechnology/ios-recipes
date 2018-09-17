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
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error{
                NSLog("Error ocured while fetching data: \(error)")
                return
            }else{
                self.allRecipes = (allRecipes ?? nil)!
            }
        }
    }
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldAction(_ sender: Any) {
        resignFirstResponder()
        filterRecipe()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let _ = segue.destination as? RecipesTableViewController else {return}
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
