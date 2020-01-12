//
//  CoreDataController.swift
//  Recipes
//
//  Created by Kenny on 1/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import Foundation

class CoreDataController {
    //MARK: Class Properties
    private let decoder = PropertyListDecoder()
    private let encoder = PropertyListEncoder()
    private let recipeFile = "recipes.plist"
    private let networkClient = RecipesNetworkClient()
    static var instance = CoreDataController()
    
    /**
       Automatically load data from disk or make an API call, assigning the result to the MainViewController when the delegate is assigned
    */
    weak var delegate: MainViewController? {
        didSet {
            createRecipeArray()
        }
    }
    
    //MARK: Computed Properties
    /**
        Any time this array is set/updated, it will save the data to disk and update the delegate
     */
    private var recipes: [Recipe] = [] {
        didSet {
            saveToPersistenStore()
            updateDelegate()
        }
    }
    
    //MARK: Create
    /**
     Loads Recipes From Persistent Store.
     
     If there are no saved recipes, makes an API call to load Recipes from remote source, then saves recipes to disk. This prevents uneccessary API calls, and prevents edited recipes from being overwritten
    */
    private func createRecipeArray() {
        loadRecipesFromPersistentStore()
        if recipes.count == 0 {
            networkClient.fetchRecipes { (recipeArray, error) in
                print("Fetching Recipes From API")
                if error != nil {
                    NSLog(error.debugDescription)
                    return
                }
                guard let recipeArray = recipeArray else {return}
                self.recipes = recipeArray
            }
        }
    }
    
    //MARK: Read
    /**
        Helper Function for Loading from disk - decodes data and attempts to return [Recipe]
     */
    private func decodeRecipeData() throws -> [Recipe] { //throwing to use in do/let/try
        guard let fileData = dataFromFileUrl(fileName: recipeFile) else { return [] }
        do {
            return try decoder.decode([Recipe].self, from: fileData)
        } catch {
            print("error decoding recipe file \(error)")
        }
        return []
    }
    
    /**
        Load the Recipes from disk and assign them to the master recipes Array
     */
    private func loadRecipesFromPersistentStore() {
        do {
            let recipeArray = try decodeRecipeData()
            self.recipes = recipeArray
        } catch {
            print("Error loading recipes from plist: \(error)")
        }
    }
    
    /*
        methods in this space may overwrite the entire recipe array. This is for convenience (runs didSet on the array)
     */
    //MARK: Update
    private func encodeRecipeData() throws -> Data { //throwing to use in do/let/try
       do {
        return try encoder.encode(recipes)
       } catch {
           print("error encoding recipe file \(error)")
       }
       return Data()
    }
    
    private func saveToPersistenStore() {
        guard let fileUrl = fileUrl(fromFileName: recipeFile, inDirectory: .documentDirectory) else {
            print("invalid file path")
            return
        }
        do {
            let recipeData = try encodeRecipeData()
            try recipeData.write(to: fileUrl)
        } catch {
            print("Error saving recipes to plist: \(error)")
        }
    }
    
    func updateRecipeName(recipe: Recipe, name: String) {
        var mutatedRecipes = recipes
        if let i = recipes.firstIndex(of: recipe) {
            mutatedRecipes[i].name = name
        }
        recipes = mutatedRecipes
    }
    
    func updateRecipeInstructions(recipe: Recipe, instructions: String) {
        var mutatedRecipes = recipes
        if let i = recipes.firstIndex(of: recipe) {
            mutatedRecipes[i].instructions = instructions
        }
        recipes = mutatedRecipes
    }
    
    
    //MARK: Helper Methods
    /**
        Constructs a fileUrl for use in Encoding/Decoding
     */
    private func fileUrl(fromFileName file: String, inDirectory directory: FileManager.SearchPathDirectory) -> URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: directory, in: .userDomainMask).first else {print("directory invalid"); return nil}
        let fileUrl = directory.appendingPathComponent(file)
        return fileUrl
    }
    
    /**
        Attempts to return Data from a fileUrl which is contructed given the filename Parameter
     */
    private func dataFromFileUrl(fileName file: String) -> Data? {
        guard let fileUrl = fileUrl(fromFileName: file, inDirectory: .documentDirectory) else {
            print("returning empty data, couldn't construct fileURL")
            return nil
        }
        do {
            let fileData = try Data(contentsOf: fileUrl)
            return fileData
        } catch {
            print("error creating Data from fileUrl \(error)")
        }
        return nil
    }
    
    /**
        Sets the MainViewController's recipes Array which updates the MainViewController's embedded UITableView
     */
    private func updateDelegate() {
        delegate?.allRecipes = recipes
    }
}
