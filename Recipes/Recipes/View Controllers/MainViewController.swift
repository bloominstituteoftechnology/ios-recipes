//
//  MainViewController.swift
//  Recipes
//
//  Created by Scott Bennett on 9/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRceipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error retrieving receipes \(error)")
                return
            }
            self.allRecipes = allRecipes ?? []
        }
    }
    
    
    @IBAction func editTextField(_ sender: Any) {
        resignFirstResponder()
        filterRceipes()
    }
    
    func filterRceipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.mainTextField.text else {
                self.filteredRecipes = self.allRecipes
                return }
            self.filteredRecipes = self.allRecipes.filter({ $0.name == searchTerm || $0.instructions == searchTerm })
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecipesTableView" {
            let recipeTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipeTableVC
        }
    }

}
