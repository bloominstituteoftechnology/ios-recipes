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
		
		fetchData()
		
    }
	
	@IBAction func editingDidEndOnExit(_ sender: Any) {
		
		print("edit")
	}
	
	private func fetchData() {
		networkClient.fetchRecipes { (recipes, error) in
			guard let recipes = recipes else {
				NSLog("networkClient error: \(error!)")
				return
			}
			
			DispatchQueue.main.async {
				self.recipesTableViewController?.recipes = recipes
//				print(recipes)
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
	
	
	
	
	@IBOutlet var editTextView: UITextField!
	
	private var recipesTableViewController: RecipesTableViewController? {
		didSet {
			print("didSet RTV")
			
		}
	}
	
	let networkClient = RecipesNetworkClient()
	
	var recipes: [Recipe] = []
	
	var filteredRecipes: [Recipe] = []
}


