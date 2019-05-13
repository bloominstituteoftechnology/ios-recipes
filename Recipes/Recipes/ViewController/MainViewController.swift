//
//  MainViewController.swift
//  Recipes
//
//  Created by Taylor Lyles on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	let networkClient = RecipesNetworkClient()
	
	var allRecipes: [Recipe] = [] {
		didSet {
			filterRecipes()
		}
	}
	
	var recipesTableViewController: RecipesTableViewController? {
		didSet {
			self.recipesTableViewController?.recipes = filteredRecipes
		}
	}
	
	var filteredRecipes: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = self.filteredRecipes
		}
	}
	
	@IBOutlet weak var textOutlet: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		networkClient.fetchRecipes { (recipes, error) in
			if let error = error {
				NSLog("Error: \(error)")
				return
			}
			DispatchQueue.main.async {
				self.allRecipes = recipes ?? []
			}
		}
		
	}
	
	func filterRecipes() {
		guard let search = textOutlet.text else { return }
		
		if search != "" {
			filteredRecipes = allRecipes.filter {
				$0.name.lowercased().contains(search.lowercased()) }
	}
}
	

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbdededSegue" {
			recipesTableViewController = (segue.destination as! RecipesTableViewController)
		}
	}
	
	
	@IBAction func textAction(_ sender: Any) {
		resignFirstResponder()
		filterRecipes()
	}
}
