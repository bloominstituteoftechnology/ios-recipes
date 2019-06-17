//
//  MainViewController.swift
//  Recipes
//
//  Created by Alex Shillingford on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    
    @IBOutlet weak var textFieldOutlet: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { recipes, error in
            if let error = error {
                print("Error loading Recipes: \(error)")
                return
            } else {
                return self.allRecipes = recipes ?? [Recipe(name: "No Recipe", instructions: "No Instructions")]
            }
        }
    }
    
    func filterRecipes() {
        guard let searchTerm = textFieldOutlet.text else { return filteredRecipes = allRecipes }
        filteredRecipes += allRecipes.filter { $0.name == searchTerm }
        filteredRecipes += allRecipes.filter { $0.instructions == searchTerm }
    }
    
    @IBAction func textFieldAction () {
        resignFirstResponder()
        filterRecipes()
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "TableViewSegue":
            guard let destinationVC = segue.destination as? RecipesTableViewController else { return }
        default:
            print("Error loading segue")
        }
    }


}
