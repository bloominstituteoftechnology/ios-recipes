//
//  MainViewController.swift
//  Recipes
//
//  Created by admin on 9/30/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    

    var networkClients = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filtereRecipes()
        }
    }
    
    var recipesTableViewController : RecipesTableViewController? {
        didSet {
            
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClients.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error loading recipe: \(error)")
            } //Something should be done here "If there is no error, set the value of allRecipes to recipes returned in this completion closure
        }
    }
    
    func filtereRecipes() {
        var words = searchTextField.text
        if words == nil {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter({ $0.name == words })
        }
    }
    
    @IBAction func searchActionTextField(_ sender: UITextField) {
        resignFirstResponder()
        filtereRecipes()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "EmbededSegue" else { return }
        
        recipesTableViewController = segue.destination as? RecipesTableViewController
        
        
    }
    
}
