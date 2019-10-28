//
//  Recipe.swift
//  App
//
//  Created by Andrew R Madsen on 8/5/18.
//

import Foundation

struct Recipe: Codable, Equatable {
    
    var name: String
    var instructions: String
    
    static var ArchiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("recipes").appendingPathExtension("plist")
        return archiveURL
    }
    
    static func saveToFile(recipes: [Recipe]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedMovies = try? propertyListEncoder.encode(recipes)
        try? encodedMovies?.write(to: Recipe.ArchiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Recipe] {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedRecipesData = try? Data(contentsOf: Recipe.ArchiveURL) {
            let decodedRecipes = try? propertyListDecoder.decode([Recipe].self, from: retrievedRecipesData)
            guard let recipes = decodedRecipes else { return [] }
            return recipes
        }
        return []
    }
}
