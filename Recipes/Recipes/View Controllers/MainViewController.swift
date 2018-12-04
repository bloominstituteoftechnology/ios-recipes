//
//  MainViewController.swift
//  Recipes
//
//  Created by Sergey Osipyan on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error geting recipes: \(error)")
                return
        }
            self.allRecipes = allRecipes ?? []
        }
    }
   private let NetworkClient = RecipesNetworkClient()
   private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
   private var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
  private  var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    func filterRecipes() {
        
        // guard let textField.text == 
    
        // need func
        
    }
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func text(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == "transfer" {
 let recipeTableVC = segue.destination as! RecipesTableViewController
 recipesTableViewController = recipeTableVC
    }
}
}
