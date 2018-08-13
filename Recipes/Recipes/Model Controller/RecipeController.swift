//
//  RecipeController.swift
//  Recipes
//
//  Created by Linh Bouniol on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

class RecipeController {
    
    static let wasUpdatedNotificaiton = Notification.Name("RecipeControllerWasUpdatedNotification")
    
    // Use local persistence so that recipes only have to be fetched from the API once
    init() {
        let wasLaunchedKey = "WasLaunched"
        
        let launchedBefore = UserDefaults.standard.bool(forKey: wasLaunchedKey)
        
        if launchedBefore {
            loadFromPersistentStore()
        } else {
            recipesNetworkClient.fetchRecipes { (recipes, error) in
                DispatchQueue.main.async {
                   if let error = error {
                        NSLog("Error geting recipes: \(error)")
                        return
                    }
                    
                    // If there is no error, get the recipes
                    self.recipes = recipes ?? []
                    
                    self.saveToPersistentStore()
                    
                    UserDefaults.standard.set(true, forKey: wasLaunchedKey)
                }
            }
        }
    }

    // MARK: - Properties
    
    var recipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            let defaultNC = NotificationCenter.default
            
            // Post new notification
            defaultNC.post(name: RecipeController.wasUpdatedNotificaiton, object: self)
        }
    }
    
    var recipesNetworkClient = RecipesNetworkClient()
    
    // MARK: - Methods
    
    func update(recipe: Recipe, name: String, instructions: String) {
        guard let index = recipes.index(of: recipe) else { return }
        
//        var recipe = recipes[index]
//        recipe.name = name
//        recipe.instructions = instructions
//
//        recipes.remove(at: index)
//        recipes.insert(recipe, at: index)
        
        // This short way is good for when there are 1-3 properties that are being modified. Anymore, then it's best to do it the other way.
        recipes[index].name = name
        recipes[index].instructions = instructions
        
        saveToPersistentStore()
    }
    
    func filterRecipes(searchTerm: String = "") {
        if searchTerm.count > 0 {
            filteredRecipes = recipes.filter({ (recipe) -> Bool in
                return recipe.name.localizedCaseInsensitiveContains(searchTerm) || recipe.instructions.localizedCaseInsensitiveContains(searchTerm)
            })
            // filteredRecipes = allRecipes.filter { $0.name.contains(searchTerm) || $0.instructions.contains(searchTerm) }
        } else {
            // Display all recipes
            filteredRecipes = recipes
        }
    }
    
    // MARK: - Persistence
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        
        guard let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentDirectory.appendingPathComponent("Recipes.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(recipes)
            try data.write(to: url)
        } catch {
            NSLog("Error saving recipes data \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        do {
            guard let url = persistentFileURL, try url.checkResourceIsReachable() else { return }
            
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedRecipes = try decoder.decode([Recipe].self, from: data)
            recipes = decodedRecipes
        } catch {
            NSLog("Error saving recipes data \(error)")
        }
    }
}
