//
//  Persister.swift
//  Recipes
//
//  Created by Nick Nguyen on 9/1/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import Foundation

struct Persister {

  let fileURL: URL

  let plistEncoder = PropertyListEncoder()

  let plistDecoder = PropertyListDecoder()


  init?(withFileName fileName: String) {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
      return nil
    }
    fileURL = url
  }

  func save<T: Codable>(_ object: T) {
    do {
      let recipesData = try plistEncoder.encode(object)
      try recipesData.write(to: fileURL)
    } catch let err as NSError {
      print(err.localizedDescription)
    }
  }

  func fetch<T: Codable>() throws -> T {
    let recipesData = try Data(contentsOf: fileURL)
    let recipes = try plistDecoder.decode(T.self, from: recipesData)
    return recipes
  }
}
