//
//  MainViewController.swift
//  Recipes
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //
    // MARK: - Outlets and Properties
    //
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
           recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    //
    // MARK: - View Lifecyles
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { allRecipes, error in
            if let error = error {
                print("Error loading recipes \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
    }
    
    //
    // MARK: - IBActions and Methods
    //
    
    @IBAction func editingDidEndOnExit(_ sender: Any) {
        searchTextField.resignFirstResponder()
        
             self.filterRecipes()
    }
    
    func filterRecipes() {
        //DispatchQueue.main.async {
            if let userSearch = self.searchTextField.text {
                self.filteredRecipes += self.allRecipes.filter { $0.name == userSearch }
                self.filteredRecipes += self.allRecipes.filter { $0.instructions == userSearch}
            }else {
                self.filteredRecipes = self.allRecipes
            }
        //}

        
    }

    //
    // MARK: - Navigation
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "EmbededSegue":
            recipesTableViewController = segue.destination as! RecipesTableViewController
            
        default:
            print("error loading embeded segue")
        }
    }
}
