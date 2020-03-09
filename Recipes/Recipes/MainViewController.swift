//
//  MainViewController.swift
//  Recipes
//
//  Created by Lydia Zhang on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var search: UITextField!
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
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
        }
    }
    
    
    func filterRecipes() {
        guard let searchContent = search.text, !searchContent.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter {
            $0.name.contains(searchContent) || $0.instructions.contains(searchContent)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes(completion: { recipes, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            if let recipes = recipes {
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
            }
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enter(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TableViewSegue" {
            guard let tableViewVC = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = tableViewVC
            
        }
    }
    

}
