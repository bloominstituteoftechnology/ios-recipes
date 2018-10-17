//
//  MainViewController.swift
//  Recipes
//
//  Created by Yvette Zhukovsky on 10/17/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var filteredRecipes: [Recipe] = [] {
        
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var allRecipes: [Recipe] = []{
        didSet{
            filterRecipes()
        }
    }
    
    
    var recipesTableViewController: RecipesTableViewController?{
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            
            
        }
        
    }
    
    func filterRecipes(){
        
        if let search = self.textField.text, search != "" {
            self.filteredRecipes = self.allRecipes.filter({$0.name.contains(search) || $0.instructions.contains(search)})
        } else {
            self.filteredRecipes = self.allRecipes
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "recipes") {
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                
                NSLog("some error\(error)")
                return
            } else {
                if let recs = recipes {
                    DispatchQueue.main.async {
                        
                        self.allRecipes = recs
                    }
                }
                
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func editingDidEnd(_ sender: Any) {
        
        filterRecipes()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
