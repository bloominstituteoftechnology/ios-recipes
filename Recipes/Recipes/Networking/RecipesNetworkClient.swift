//
//  RecipesNetworkClient.swift
//  Recipes
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct RecipesNetworkClient {
    
    var recipes: [Recipe] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    static let recipesURL = URL(string: "https://lambdacookbook.vapor.cloud/recipes")!
    
    func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: RecipesNetworkClient.recipesURL) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    var persistenceURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = documentDirectory.appendingPathComponent("recipes.plist")
        return fileName
    }
    mutating func deleteRecipe(remove recipe: Recipe) {
        if let index = recipes.firstIndex(of: recipe) {
            recipes.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    mutating func updateRecipe(recipe: Recipe, name: String, instructions: String) {
        
        deleteRecipe(remove: recipe)
        let updatedRecipe = Recipe(name: name, instructions: instructions)
        recipes.append(updatedRecipe)
        
        saveToPersistentStore()
    }
    
    func saveToPersistentStore(){
        guard let url = persistenceURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(recipes)
            try data.write(to: url)
        } catch {
            print("Error with plistencoder: \(error)")
            return
        }
    }
    
    mutating func loadFromPersistentStore(){
        let fm = FileManager.default
        guard let url = persistenceURL, fm.fileExists(atPath: url.path) else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let loadedRecipes = try decoder.decode([Recipe].self, from: data)
            recipes = loadedRecipes
        } catch  {
            print("Error with plistencoder: \(error)")
            return
        }
    }
}
