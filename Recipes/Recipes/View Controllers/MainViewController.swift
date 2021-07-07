//
//  MainViewController.swift
//  Recipes
//
//  Created by David Wright on 1/15/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()

    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // MARK: - Outlets

    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - IBActions

    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Properties
    
    func filterRecipes() {
        guard let searchTerm = searchTextField.text,
        searchTerm != "" else {
            filteredRecipes = allRecipes
            return
        }
        
        filteredRecipes = allRecipes.filter {
            $0.name.contains(searchTerm) ||
            $0.instructions.contains(searchTerm)
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            guard error == nil else {
                print("Error loading recipes: \(error!)")
                return
            }
            
            guard let allRecipes = allRecipes else {
                print("Error allRecipes was nil!")
                return
            }
            
            DispatchQueue.main.async {
                self.allRecipes = allRecipes
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EmbededTableVCSegue",
        let recipesTableVC = segue.destination as? RecipesTableViewController else { return }
        
        self.recipesTableViewController = recipesTableVC
    }

}
