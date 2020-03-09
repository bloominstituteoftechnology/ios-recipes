//
//  RecipesNetworkClient.swift
//  Recipes
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation

struct RecipesNetworkClient {
    
    static let recipesURL = URL(string: "https://lambdacookbook.vapor.cloud/recipes")!
    
    func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        
        let request = URLRequest(url: RecipesNetworkClient.recipesURL)
        
        // Try to load recipes from cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            do {
                let recipes = try JSONDecoder().decode([Recipe].self, from: cachedResponse.data)
                completion(recipes, nil)
                return
            } catch {
                // If we can't decode, we will simply log the error, and try downloading the recipes again
                NSLog("Error decoding cached recipes: \(error)")
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                NSLog(response?.description ?? "No response description")
                completion(nil, NSError())
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
            
            // Cache response
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)
            
        }.resume()
    }
}
