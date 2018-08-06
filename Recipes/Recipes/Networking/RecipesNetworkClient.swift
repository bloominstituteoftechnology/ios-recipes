//
//  RecipesNetworkClient.swift
//  Recipes
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

class RecipesNetworkClient {
    
    static let recipesURL = URL(string: "https://cookbook.vapor.cloud/recipes")!
    
    func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        if let localRecipes = loadFromPersistence() {
            completion(localRecipes, nil)
            return
        }
        
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
                self.saveToPersistence(for: recipes)
                self.recipes = recipes
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    func updateRecipes(for recipe: Recipe, instructions: String) {
        guard let index = recipes.index(of: recipe) else { return }
        var recipe = recipes[index]
        recipe.instructions = instructions
        recipes.remove(at: index)
        recipes.insert(recipe, at: index)
        saveToPersistence(for: recipes)
    }
    
    private func saveToPersistence(for recipes: [Recipe]) {
        let encoder = PropertyListEncoder()
        guard let url = persistenceStoreURL else { return }
        
        do {
            let data = try encoder.encode(recipes)
            try data.write(to: url)
            userDefaults.set(true, forKey: "recipesHaveBeenCached")
        } catch {
            NSLog("Error occured while saving recipes data to PropertyList: \(error)")
        }
        
    }
    
    func loadFromPersistence() -> [Recipe]? {
        if userDefaults.bool(forKey: "recipesHaveBeenCached") {
            let decoder = PropertyListDecoder()
            guard let url = persistenceStoreURL else { return nil }
            
            do {
                let data = try Data(contentsOf: url)
                let recipes = try decoder.decode([Recipe].self, from: data)
                self.recipes = recipes
                return recipes
            } catch {
                NSLog("Error occured while loading recipes data from PropertyList: \(error)")
                return nil
            }
        }
        return nil
    }
    
    var recipes: [Recipe] = []
    let userDefaults = UserDefaults()
    
    var persistenceStoreURL: URL? {
        let fm = FileManager.default
        let fileName = "recipes.plist"
        if let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            return documentsDir.appendingPathComponent(fileName)
        }
        return nil
    }
    
}
