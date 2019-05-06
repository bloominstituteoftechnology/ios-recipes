//
//  MainViewController.swift
//  Recipes
//
//  Created by Hector Steven on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	private func filterRecipes() {
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchData()
    }
	
	
	
	
	
	private func fetchData() {
		networkClient.fetchRecipes { (recipes, error) in
			guard let recipes = recipes else {
				NSLog("networkClient error: \(error!)")
				return
			}
			
			DispatchQueue.main.async {
				self.recipesTableViewController?.recipes = recipes
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
	var recipes: [Recipe] = []
	var filteredRecipes: [Recipe] = []
	
	private var readingListURL: URL? {
		let fileManager = FileManager.default
		guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		let fileName = "Recipes.plist"
		let document = documents.appendingPathComponent(fileName)
		return document
	}
}

extension MainViewController {
	func saveToPersistentStore() {
		guard let url = readingListURL else { return }
		
		do {
			let encoder = PropertyListEncoder()
			let data = try encoder.encode(recipes)
			try data.write(to: url)
		} catch {
			NSLog("Error saving book data: \(error)")
		}
	}
	
	func loadFromPersistentStore() {
		let fileManager = FileManager.default
		
		guard let url = readingListURL,
			fileManager.fileExists(atPath: url.path) else {
				print("error: loadFromPersistentStore()")
				return
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = PropertyListDecoder()
			let decodedrecipies = try decoder.decode([Recipe].self, from: data)
			recipes = decodedrecipies
		}catch {
			NSLog("Error loading book data: \(error)")
		}
	}
	
}


extension MainViewController: UISearchBarDelegate {
	
}
