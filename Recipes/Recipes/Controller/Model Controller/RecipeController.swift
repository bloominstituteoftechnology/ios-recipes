//
//  RecipeController.swift
//  Recipes
//
//  Created by Chad Rutherford on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeController {
    
    var recipes = [Recipe]()
    
    init() {
        loadFromPersistentStore()
    }
    
    var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent("Recipes.plist")
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        do {
            let recipeData = try Data(contentsOf: url)
            self.recipes = try decoder.decode([Recipe].self, from: recipeData)
        } catch let decodeError {
            print("Error decoding recipes: \(decodeError.localizedDescription)")
        }
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = persistentFileURL else { return }
        do {
            let recipeData = try encoder.encode(recipes)
            try recipeData.write(to: url)
        } catch let encodeError {
            print("Error encoding recipes: \(encodeError.localizedDescription)")
        }
    }
}
