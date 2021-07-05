//
//  RecipesNetworkClient.swift
//  Recipes
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct RecipesNetworkClient {
    
    static let recipesURL = URL(string: "https://lambdarecipeapi.herokuapp.com/recipes")!
    
    func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        let recipes = Recipe.loadFromFile()
        if !recipes.isEmpty {
            print("Recipes on disk.")
            completion(recipes, nil)
            return
        }
        
        URLSession.shared.dataTask(with: RecipesNetworkClient.recipesURL) { (data, _, error) in
            
            print("Recipes not on disk. Fetching...")
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
                Recipe.saveToFile(recipes: recipes)
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
}
