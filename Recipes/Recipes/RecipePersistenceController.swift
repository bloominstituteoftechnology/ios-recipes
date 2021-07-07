//
//  RecipePersistenceController.swift
//  Recipes
//
//  Created by denis cedeno on 10/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation
class RecipePersistanceController {
    
    var recipe: [Recipe] = []
    
    init() {
           loadFromPersistentStore()
    }
    
    var persistentFileURL: URL? {
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileName = "Recipe.plist"
            return dir?.appendingPathComponent(fileName)
        
        }
        
        func loadFromPersistentStore() {
            do{
                guard let url = persistentFileURL else { return }
                let recipeData = try Data(contentsOf: url)
                self.recipe = try PropertyListDecoder().decode([Recipe].self, from: recipeData)
                print("\(String(describing: persistentFileURL))")
            } catch{
                NSLog("error with data: \(error)")
            }
        }
        
        func saveToPersistentStore() {
            let recipeEncoder = PropertyListEncoder()
            do{
                let data = try recipeEncoder.encode(recipe)
                guard let url = persistentFileURL else {return}
                try data.write(to: url)
            } catch{
                NSLog("error saving to plist or writing data: \(error)")
            }
        }
        
}
