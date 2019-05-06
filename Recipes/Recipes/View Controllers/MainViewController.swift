//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	let networkClient = RecipesNetworkClient()
	var allRecipes: [Recipe] = [] {
		didSet {
			guard let searchText = searchBar.text else {
				filterRecipes(with: nil, scope: nil)
				return
			}
			let scope: FilterScope
			switch searchBar.selectedScopeButtonIndex {
			case 0:
				scope = .name
			case 1:
				scope = .allContents
			default:
				scope = .name
			}
			filterRecipes(with: searchText, scope: scope)
		}
	}
	var filteredRecipes: [Recipe] = [] {
		didSet {
			recipesTableViewController?.recipes = filteredRecipes
		}
	}
	var recipesTableViewController: RecipesTableViewController? {
		didSet {
			recipesTableViewController?.recipes = filteredRecipes
		}
	}

	@IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

		networkClient.fetchRecipes { (recipes, error) in
			guard error == nil else {
				print("ERRORINATED: \(error!)")
				return
			}

			if let recipes = recipes {
				DispatchQueue.main.async {
					self.allRecipes = recipes
				}
			}
		}
	}

	enum FilterScope {
		case name
		case allContents
	}
	func filterRecipes(with searchText: String?, scope: FilterScope?) {
		guard let searchText = searchText, !searchText.isEmpty, let scope = scope else {
			filteredRecipes = allRecipes
			return
		}
		switch scope {
		case .name:
			filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
		case .allContents:
			filteredRecipes = allRecipes.filter { $0.name.lowercased().contains(searchText.lowercased()) ||
				$0.instructions.lowercased().contains(searchText.lowercased()) }
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbedRecipesTableViewController" {
			let dest = segue.destination as? RecipesTableViewController
			recipesTableViewController = dest
		}
	}
}

extension MainViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		let scope: FilterScope
		switch searchBar.selectedScopeButtonIndex {
		case 0:
			scope = .name
		case 1:
			scope = .allContents
		default:
			scope = .name
		}

		filterRecipes(with: searchText, scope: scope)
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		let scope: FilterScope
		switch searchBar.selectedScopeButtonIndex {
		case 0:
			scope = .name
		case 1:
			scope = .allContents
		default:
			scope = .name
		}
		filterRecipes(with: searchBar.text, scope: scope)
	}

	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		let scope: FilterScope
		switch selectedScope {
		case 0:
			scope = .name
		case 1:
			scope = .allContents
		default:
			scope = .name
		}
		filterRecipes(with: searchBar.text, scope: scope)
	}
}
