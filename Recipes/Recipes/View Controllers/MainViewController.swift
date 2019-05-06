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
		
		
	}
	
	private func fetchData() {
		networkClient.fetchRecipes { (recipes, error) in
			guard let recipes = recipes else {
				NSLog("networkClient error: \(error!)")
				return
			}
			
			DispatchQueue.main.async {
				self.recipes = recipes
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbededTableViewController" {
			
			guard let vc = segue.destination as? RecipesTableViewController else {
				print("error: prepare(for segue: ,EmbededTableViewController")
				return
			}
			vc.recipes = recipes
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
}


