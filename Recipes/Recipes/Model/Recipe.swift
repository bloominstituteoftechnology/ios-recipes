//
//  Recipe.swift
//  App
//
//  Created by Andrew R Madsen on 8/5/18.
//

import Foundation

struct Recipe: Codable {
    var name: String
    var instructions: String
    var ingredients: String
    var cookTime: String
    var servings: String
    var difficulty: String
    var prepTime: String
    var totalTime: String
    var mealTime: String
    
}
