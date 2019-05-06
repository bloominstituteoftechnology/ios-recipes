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
}


extension MainViewController: UISearchBarDelegate {
	
}
