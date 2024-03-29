//
//  RecipesNetworkClient.swift
//  Recipes
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2021 Bloom Institute of Technology Inc. All rights reserved.
//

import Foundation

struct RecipesNetworkClient {
    
    static let recipesURL = URL(string: "https://lambdarecipeapi.herokuapp.com/recipes")!
    
    func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: RecipesNetworkClient.recipesURL) { (data, _, error) in
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
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
}
