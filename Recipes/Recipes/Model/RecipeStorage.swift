//
//  RecipeController.swift
//  Recipes
//
//  Created by Nick Nguyen on 9/1/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import Foundation

class RecipeStorage {
  
  var filteredRecipes: [Recipe] = []
  var recipes: [Recipe] = []
  
  let fileName = "Recipe.plist"
  
  var pesister: Persister {
    Persister(withFileName: fileName)!
  }
  
   func loadPersistent() {
    do {
      self.recipes = try pesister.fetch()
    } catch {
      print(error.localizedDescription)
    }
   
  }
  
  func update(_ recipe: Recipe, name: String, instructions: String) {
      guard let index = recipes.firstIndex(of: recipe) else { return }
      
      recipes[index].name = name
      recipes[index].instructions = instructions
      
    self.pesister.save(recipes)
  }
}
