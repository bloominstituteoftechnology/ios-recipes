//
//  MainViewController.swift
//  Recipes
//
//  Created by Hector Steven on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	
    override func viewDidLoad() {
        super.viewDidLoad()
		searchBar.delegate = self
		if !loadFromPersistentStore() {
				fetchData()
		}
		
		print(allRecipes)
    }
	
	private func fetchData() {
		networkClient.fetchRecipes { (recipes, error) in
			guard let recipes = recipes else {
				NSLog("networkClient error: \(error!)")
				return
			}
			
			DispatchQueue.main.async {
				self.allRecipes = recipes.sorted {
					($0.name)  < ($1.name )
				}
				self.saveToPersistentStore()
				
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbededTableViewController" {
			
			guard let vc = segue.destination as? RecipesTableViewController else {
				print("error: prepare(for segue: ,EmbededTableViewController")
				return
			}
			recipesTableViewController = vc
		}
	}
	
	@IBOutlet var searchBar: UISearchBar!
	private var recipesTableViewController: RecipesTableViewController?
	let networkClient = RecipesNetworkClient()
	
	var allRecipes: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = allRecipes
		}
	}

	var filteredRecipes: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = filteredRecipes
		}
	}
	
	private var readingListURL: URL? {
		let fileManager = FileManager.default
		guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		let fileName = "AllRecipes.plist"
		let document = documents.appendingPathComponent(fileName)
		return document
	}
}

extension MainViewController {
	func loadFromPersistentStore() -> Bool{
		let fileManager = FileManager.default
		
		guard let url = readingListURL,
			fileManager.fileExists(atPath: url.path) else {
				print("error: loadFromPersistentStore()")
				return false
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			let decodedrecipies = try decoder.decode([Recipe].self, from: data)
			self.allRecipes = decodedrecipies
		}catch {
			NSLog("Error loading book data: \(error)")
			fetchData()
		}
		
		return true
	}
	
	func saveToPersistentStore() {
		guard let url = readingListURL else { return }
		
		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(allRecipes)
			try data.write(to: url)
		} catch {
			NSLog("Error saving book data: \(error)")
		}
	}
}


extension MainViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if !searchText.isEmpty {
			filterRecipes(searchText: searchText)
		} else {
			filteredRecipes = allRecipes
		}
	}
	
	private func filterRecipes(searchText: String) {
		let searchText = searchText.lowercased()
		var updateRecipe: [Recipe] = []
		for recipe in allRecipes {
			let name = recipe.name.lowercased()
			let instructions = recipe.instructions.lowercased()

			if name.contains(searchText) || instructions.contains(searchText) {
				updateRecipe.append(recipe)
			}
		}
		
		filteredRecipes = updateRecipe.sorted {
			($0.name)  < ($1.name )
		}
	}
}
