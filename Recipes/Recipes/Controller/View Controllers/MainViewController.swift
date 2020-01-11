//
//  MainViewController.swift
//  Recipes
//
//  Created by Kenny on 1/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var textField: UITextField!
    
    //MARK: IBActions
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    //MARK: Class Properties
    let coreDataController = CoreDataController.instance
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController!.recipes = filteredRecipes
        }
    }
    
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
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataController.delegate = self
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainTableViewEmbedSegue" {
            guard let destination = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = destination
        }
    }
    
    //MARK: Helper Methods
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let recipeName = self.textField.text,
                      recipeName != "" else {
                        self.filteredRecipes = self.allRecipes
                return
            }
            self.filteredRecipes = self.allRecipes.filter {$0.name.uppercased().contains(recipeName.uppercased())}
        }
    }
}
