//
//  RecipeController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_259 on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import Foundation


class RecipeController {
    
    // MARK: - Properties
    private(set) var recipes: [Recipe] = []
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("recipe.plist")
    }
    
    static let recipeController = RecipeController()
    
    // MARK: - CRUD
    func createRecipe(name: String, instructions: String) {
        let recipe = Recipe(name: name, instructions: instructions)
        recipes.append(recipe)
        saveToPersistentStore()
    }
    
    func retrieveRecipe(name: String) -> Int? {
        for i in 0..<recipes.count {
            if recipes[i].name == name {
                return i
            }
        }
        return nil
    }
    
    func updateRecipe(name: String, instructions: String) {
        guard let index = retrieveRecipe(name: name) else { return }
        recipes[index].instructions = instructions
        saveToPersistentStore()
    }
    
    func deleteRecipe(name: String) {
        guard let index = retrieveRecipe(name: name) else { return }
        recipes.remove(at: index)
        saveToPersistentStore()
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
