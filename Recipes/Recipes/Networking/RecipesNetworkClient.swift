//
//  RecipesNetworkClient.swift
//  Recipes
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct RecipesNetworkClient {
    
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
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
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
    
    private func loadFromPersistence() -> [Recipe]? {
        if userDefaults.bool(forKey: "recipesHaveBeenCached") {
            let decoder = PropertyListDecoder()
            guard let url = persistenceStoreURL else { return nil }
            
            do {
                let data = try Data(contentsOf: url)
                return try decoder.decode([Recipe].self, from: data)
            } catch {
                NSLog("Error occured while loading recipes data from PropertyList: \(error)")
                return nil
            }
        }
        return nil
    }
    
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
