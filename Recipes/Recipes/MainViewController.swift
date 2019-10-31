//
//  MainViewController.swift
//  Recipes
//
//  Created by denis cedeno on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            self.recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion: { recipes , error in
            if let error = error {
                print("Error loading recipe: \(error)")
                return
            }
            DispatchQueue.main.async {
                if let recipes = recipes {
                    self.allRecipes = recipes
                }
            }
        })
    }
    
    @IBAction func searchAction(_ sender: UITextField) {
        searchTextField.resignFirstResponder()
        filterRecipes()
    }
    
    


    func filterRecipes() {

        guard let searchText = searchTextField.text,
            !searchText.isEmpty else { return filteredRecipes = allRecipes }
        
        filteredRecipes = allRecipes.filter { $0.name.contains(searchText) || $0.instructions.contains(searchText) }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conatinerSegue" {
            guard let TVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = TVC
        }
    }
    

}
