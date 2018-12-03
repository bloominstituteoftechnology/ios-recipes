//
//  MainViewController.swift
//  Recipes
//
//  Created by Benjamin Hakes on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error getting students: \(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }

        // Do any additional setup after loading the view.
    }
    let networkClient = RecipesNetworkClient()
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    var allRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func editingDidEnd(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "embededTableViewSegue"{
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    private func filterRecipes(){
        
        DispatchQueue.main.async {
        guard let search = self.textField.text, self.textField.text != nil else {self.filteredRecipes = self.allRecipes
            return
            }
        
            self.filteredRecipes = self.allRecipes.filter{ $0.name.contains(search)}
        }
        
    }

}
