//
//  MainViewController.swift
//  Recipes
//
//  Created by Fabiola S on 9/4/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController?
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            self.allRecipes = allRecipes ?? []
        }
    }
    
    // MARK: IBActions
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: Functions
    func filterRecipes() {
        DispatchQueue.main.async {
            
            guard let enteredText = self.textField.text,
                !enteredText.isEmpty else {
                    self.filteredRecipes = self.allRecipes
                    return }
            
            self.filteredRecipes = self.allRecipes.filter { ($0.name.range(of: enteredText, options: .caseInsensitive) != nil) || ($0.instructions.range(of: enteredText, options: .caseInsensitive) != nil)}
            
            
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableViewSegue" {
            guard let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipesTableVC
        }
    }
    
    
}
