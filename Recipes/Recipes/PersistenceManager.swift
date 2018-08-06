//
//  Persistence.swift
//  Recipes
//
//  Created by Simon Elhoej Steinmejer on 06/08/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

class PersistenceManager
{
    static let shared = PersistenceManager()
    private var persistentFileURL: URL?
    {
        let fm = FileManager.default
        guard let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent("recipes.plist")
    }
    
    func saveToPersistence(recipes: [Recipe])
    {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(recipes)
            try data.write(to: url)
        } catch {
            NSLog("Error saving recipes: \(error)")
        }
    }
    
    func loadFromPersistence(completetion: ([Recipe]?, Error?) -> ())
    {
        let recipes: [Recipe]
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            recipes = try decoder.decode([Recipe].self, from: data)
            completetion(recipes, nil)
        } catch {
            NSLog("Error loading recipes: \(error)")
            completetion(nil, error)
        }
    }
}
