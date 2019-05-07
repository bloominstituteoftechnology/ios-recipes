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
			let scope = FilterScope.getScopeForIndex(searchBar.selectedScopeButtonIndex)
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
//		styleScope()
	}

	func styleScope() {
		for subview in searchBar.allSubviews() {
			if let selector = subview as? UISegmentedControl {
				selector.tintColor = .yellow
				subview.backgroundColor = .clear
			} else if let textField = subview as? UITextField {
				textField.backgroundColor = .white
			} else {
				subview.backgroundColor = .clear
			}
		}
	}

	enum FilterScope {
		case name
		case allContents
		static func getScopeForIndex(_ index: Int) -> FilterScope {
			switch index {
			case 0:
				return .name
			case 1:
				return .allContents
			default:
				return .allContents
			}
		}
	}
	func filterRecipes(with searchText: String?, scope: FilterScope?) {
		guard let searchText = searchText, !searchText.isEmpty, let scope = scope else {
			filteredRecipes = allRecipes
			return
		}

		let searchTerms = searchText.split(separator: " ").map { String($0) }

		var tempFilterRecipes = allRecipes
		for term in searchTerms {
			switch scope {
			case .name:
				tempFilterRecipes = tempFilterRecipes.filter { $0.name.lowercased().contains(term.lowercased()) }
			case .allContents:
				tempFilterRecipes = tempFilterRecipes.filter { $0.name.lowercased().contains(term.lowercased()) ||
					$0.instructions.lowercased().contains(term.lowercased()) }
			}
		}
		filteredRecipes = tempFilterRecipes
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
		let scope = FilterScope.getScopeForIndex(searchBar.selectedScopeButtonIndex)
		filterRecipes(with: searchText, scope: scope)
	}

	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		let scope = FilterScope.getScopeForIndex(selectedScope)
		filterRecipes(with: searchBar.text, scope: scope)
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		let scope = FilterScope.getScopeForIndex(searchBar.selectedScopeButtonIndex)
		filterRecipes(with: searchBar.text, scope: scope)
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		searchBar.text = ""
		let scope = FilterScope.getScopeForIndex(searchBar.selectedScopeButtonIndex)
		filterRecipes(with: searchBar.text, scope: scope)

	}

	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		searchBar.showsScopeBar = true
		searchBar.sizeToFit()
		styleScope()
		searchBar.setShowsCancelButton(true, animated: true)
		return true
	}

	func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
		searchBar.showsScopeBar = false
		searchBar.sizeToFit()
		searchBar.setShowsCancelButton(false, animated: true)
		return true

	}
}
