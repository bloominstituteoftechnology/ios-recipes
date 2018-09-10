//
//  MainViewController.swift
//  Recipes
//
//  Created by Moin Uddin on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("There was an error with fetching the recipes: \(error)")
            }
            else if let recipes = recipes {
                DispatchQueue.main.sync {
                    self.allRecipes = recipes
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        self.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        guard let recipeSearchTerm = recipeSearchTextField.text else {
            filteredRecipes = allRecipes
            return
        }
        if recipeSearchTerm == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter({ (recipe) -> Bool in
                recipe.name.contains(recipeSearchTerm) || recipe.instructions.contains(recipeSearchTerm)
            })
            
        }
        
    }
    
    
    @IBOutlet weak var recipeSearchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EmbedRecipesTVC" {
            recipesTableViewController = segue.destination as! RecipesTableViewController
        }

        
    }


}
