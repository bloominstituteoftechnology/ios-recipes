//
//  MainViewController.swift
//  Recipes
//
//  Created by Andrew Liao on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipe, error) in
            if let error = error {
                NSLog("Error: \(error)")
            }
            guard let recipe = recipe else {return}
            self.allRecipes = recipe
        }
    }
    
    func filterRecipes(){
        DispatchQueue.main.async {
            
            if let searchTerm = self.searchLabel.text,
                searchTerm != "" {
                self.filteredRecipes = self.allRecipes.filter{$0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)}
            } else{
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    @IBAction func editingDidEnd(_ sender: Any) {
        searchLabel.resignFirstResponder()
        filterRecipes()
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableVC"{
            recipesTableViewController = segue.destination as! RecipesTableViewController
            
        }
    }
    
    
    // MARK: - Properties
    @IBOutlet weak var searchLabel: UITextField!
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet{
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController?{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes = [Recipe](){
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
}
