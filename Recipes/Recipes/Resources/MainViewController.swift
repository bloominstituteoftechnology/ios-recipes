//
//  MainViewController.swift
//  Recipes
//
//  Created by Chris Gonzales on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []{
        didSet{
            filterRecipes()
        }
    }
    var recipesTableVC: RecipesTableViewController?{
        didSet{
            recipesTableVC?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = []{
        didSet{
            recipesTableVC?.recipes = filteredRecipes
        }
    }
    
    // MARK: - Methods
    
    func filterRecipes(){
        
        guard let text = recipeTextField.text,
            !text.isEmpty else { filteredRecipes = allRecipes
                return }
     
        filteredRecipes = allRecipes.filter { $0.name.contains(text)  || $0.instructions.contains(text)}
        
        
    }
    
    // MARK: - Outlets and Actions

    @IBOutlet weak var recipeTextField: UITextField!
    
    
    @IBAction func RecipeTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        filterRecipes()
    }
    
  
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (recipes, error) in
            if let error = error{
                NSLog("Error fetching recipes: \(error)")
                return
            }
            
            DispatchQueue.main.async {
               // guard let recipes = recipes else { return }
                self.allRecipes = recipes ?? []
            }
            }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueKeys.recipeTableVCSegue {
            recipesTableVC = (segue.destination as! RecipesTableViewController)
           // recipeTableVC.recipes = filteredRecipes
        }
    
    }
    

}
