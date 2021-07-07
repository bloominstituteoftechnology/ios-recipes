//
//  RecipeController.swift
//  Recipes
//
//  Created by Claudia Contreras on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import Foundation

class RecipeController {
    
    // MARK: - Private Properties
    private var recipes: [Recipe] = []
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("recipes.plist")
    }
    
    
    // MARK: - Persistence
    func saveToPersistentStore(_ recipes: [Recipe]? = nil) {
        guard let url = persistentFileURL else { return }
        let encoder = PropertyListEncoder()
        if let recipes = recipes {
            do {
                let data = try encoder.encode(recipes)
                try data.write(to: url)
            } catch {
                print("Error saving recipe data: \(error)")
            }
        } else {
            do {
                let data = try encoder.encode(self.recipes)
                try data.write(to: url)
            } catch {
                print("Error saving recipe data: \(error)")
            }
        }
    }

    func loadFromPersistentStore() {

        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else {
            return }

        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            recipes = try decoder.decode([Recipe].self, from: data)
        } catch {
            print("error loading recipe data: \(error)")
        }
    }
}
