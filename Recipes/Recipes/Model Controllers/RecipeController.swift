//
//  RecipeController.swift
//  Recipes
//
//  Created by Jeremy Taylor on 5/12/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class RecipeController {
    var allRecipes = [Recipe]()
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        
        guard let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("recipes.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(allRecipes)
            try data.write(to: url)
        } catch {
            NSLog("Couldn't save recipe data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let fm = FileManager.default
            guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedRecipes = try decoder.decode([Recipe].self, from: data)
            allRecipes = decodedRecipes
        } catch {
            NSLog("Couldn't load recipe data: \(error)")
        }
    }
}
