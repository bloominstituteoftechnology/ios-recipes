//
//  MainViewController.swift
//  Recipes
//
//  Created by Carolyn Lea on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var searchTextField: UITextField!
    var didSave:Bool?
    var recipesTableViewController: RecipesTableViewController?
    {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = []
    {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
//        let userDefaults = UserDefaults.standard
//        userDefaults.bool(forKey: "DidSave")
        
//        if didSave == true
//        {
           loadFromPersistentStore()
//        }
//        else
//        {
            networkClient.fetchRecipes { (recipes, error) in
                if let error = error
                {
                    NSLog("Error getting recipes: \(error)")
                    return
                }
                self.allRecipes = recipes ?? []
                self.saveToPersistentStore()
//                self.didSave = true
//                userDefaults.set(true, forKey: "DidSave")
//            }
        }
    }

    func filterRecipes()
    {
        DispatchQueue.main.async {
            guard let searchTerm = self.searchTextField.text else {return}
            if searchTerm == ""
            {
                self.filteredRecipes = self.allRecipes
                print(self.filteredRecipes)
            }
            else
            {
                self.filteredRecipes = self.allRecipes.filter{$0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)}
                print(self.filteredRecipes)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        view.endEditing(true)
        filterRecipes()
        recipesTableViewController?.tableView.reloadData()
        return true
    }
    
 
    @IBAction func search(_ sender: Any)
    {
        view.endEditing(true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "EmbedRecipeTableView"
        {
            let recipeTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipeTableVC
        }
    }
    
    // MARK: - Persistent Store
    
    private var recipeListURL: URL?
    {
        let fileManager = FileManager.default
        
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("RecipeList.plist")
    }
    
    func saveToPersistentStore()
    {
        guard let url = recipeListURL else {return}
        
        do
        {
            let encoder = PropertyListEncoder()
            let recipesData = try encoder.encode(allRecipes)
            try recipesData.write(to: url)
            print("saved")
        }
        catch
        {
            NSLog("Error saving recipes data: \(error)")
        }
    }
    
    func loadFromPersistentStore()
    {
        let fileManager = FileManager.default
        
        do
        {
            guard let url = recipeListURL, fileManager.fileExists(atPath: url.path) else {return}
            let recipesData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedRecipes = try decoder.decode([Recipe].self, from: recipesData)
            allRecipes = decodedRecipes
            print("loaded")
        }
        catch
        {
            NSLog("Error saving recipes data: \(error)")
        }
    }

}
