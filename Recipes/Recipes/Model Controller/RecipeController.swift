//
//  RecipeController.swift
//  Recipes
//
//  Created by Eoin Lavery on 05/09/2019.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class RecipeController {
    
    private(set) var recipes: [Recipe] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    //Gets URL for LocalStorage file holding data for persistence
    var recipeBookURL: URL? {
        let fileManager = FileManager()
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("RecipeBook.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = recipeBookURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let recipeData = try(encoder.encode(recipes))
            try recipeData.write(to: url)
        } catch {
            print("Error storing data to file: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = recipeBookURL, fileManager.fileExists(atPath: url.path) else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data.init(contentsOf: url)
            let decodedRecipes = try decoder.decode([Recipe].self, from: data)
            recipes = decodedRecipes
        } catch {
            print("Error loading data from file: \(error)")
        }
    }
    
    func saveOnlineRecipes(recipesToSave: [Recipe]) {
        recipes = recipesToSave
    }
    
}
