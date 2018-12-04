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

        NetworkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error geting recipes: \(error)")
                return
        }
            self.allRecipes = recipes ?? []
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
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
  
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func text(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    func filterRecipes() {
        
        DispatchQueue.main.async {
            guard let text = self.textField?.text, !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            // need func
            
        }
    }
    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == "transfer" {
 let recipeTableVC = segue.destination as! RecipesTableViewController
 recipesTableViewController = recipeTableVC
    }
}

}
