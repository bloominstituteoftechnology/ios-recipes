//
//  MainViewController.swift
//  Recipes
//
//  Created by Victor  on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    //passing data
    let networkClient = RecipesNetworkClient()
    
    //creating array to hold recipes
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    //array to hold filtered recipes
    var filteredRecipes: [Recipe] = [] {
        didSet {
            //updates table view
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    //checking for table view
    var recipesTableViewController: RecipesTableViewController?
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    func filterRecipes() {
        //main thread ui
        DispatchQueue.main.async {
            //logic to unwrap text and filter search
            guard let searchText = self.textField.text, searchText != "" else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            self.filteredRecipes = self.allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.instructions.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    //api request
    func fetch() {
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                print(error)
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    //filters data when user is done editing
    @IBAction func textFieldDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    //navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableView" {
            guard let destinationVC = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = destinationVC
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .white
    }
}
