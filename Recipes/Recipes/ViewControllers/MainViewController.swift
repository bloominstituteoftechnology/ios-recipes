//
//  MainViewController.swift
//  Recipes
//
//  Created by Jonathan T. Miles on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromPersistentStore()
        if allRecipes.isEmpty {
            networkClient.fetchRecipes { (recipes, error) in
                if let error = error {
                    NSLog("Error loading recipes: \(error)")
                }
                guard let recipe = recipes else { return }
                self.allRecipes = recipe
                self.saveToPersistentStore()

            }
        } /* else {
            self.persistenceHelper.loadFromPersistentStore()
            self.allRecipes = self.persistenceHelper.localRecipes
        } */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchRecipes(_ sender: Any) {
        searchRecipeTextField.resignFirstResponder()
        filterRecipes()
    }
    
    
    // Custom functions
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let enteredText = self.searchRecipeTextField.text else { return }
            if enteredText == "" {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains(enteredText) || $0.instructions.contains(enteredText) }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeTableViewSegue" {
            let destVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destVC
        }
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        guard let url = persistentURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allRecipes)
            try data.write(to: url)
        } catch {
            NSLog("Error saving recipes: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentURL, fm.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            allRecipes = try decoder.decode([Recipe].self, from: data)
        } catch {
            NSLog("Error loading recipes: \(error)")
        }
    }
    
    // Persistent URL
    var persistentURL: URL? {
        let fm = FileManager.default
        guard let docsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return docsDir.appendingPathComponent("recipes.plist")
    }
    
    
    // MARK: - Properties
    
    let networkClient = RecipesNetworkClient()
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
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
    
    @IBOutlet weak var searchRecipeTextField: UITextField!
    
}
