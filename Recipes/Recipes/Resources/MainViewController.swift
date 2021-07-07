//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_268 on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Something's wrong! Error: \(error)")
            }
            self.allRecipes = allRecipes ?? []
        }

        // Do any additional setup after loading the view.
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var mainViewTextField: UITextField!
    
    @IBAction func mainViewTextFieldAction(_ sender: Any) {
        self.resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
        
        DispatchQueue.main.async {
            guard let userInput = self.mainViewTextField.text, !userInput.isEmpty else { self.filteredRecipes = self.allRecipes
                return
            }
            self.filteredRecipes = self.allRecipes.filter {
                ($0.name.contains(userInput)) || ($0.instructions.contains(userInput))
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "containerToTableView" {
             recipesTableViewController = segue.destination as? RecipesTableViewController
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
