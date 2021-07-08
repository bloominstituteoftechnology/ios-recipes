//
//  MainViewController.swift
//  Recipes
//
//  Created by Farhan on 9/10/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        networkClient.fetchRecipes { (recipesFromDB, error) in
            
            if (error != nil) {
                NSLog("error fetching recipes!: \(String(describing: error))")
                return
            }
            self.allRecipes = recipesFromDB!
            
        }
    }
    @IBAction func searchRecipes(_ sender: Any) {
        
        self.resignFirstResponder()
        filterRecipes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterRecipes(){
        DispatchQueue.main.async {
            // Make sure there is a search term, otherwise set the filtered recipes to all the recipes
            guard let searchTerm = self.searchTextField.text, !searchTerm.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            // Get the recipes who's names match
            let namesMatch = self.allRecipes.filter { $0.name.range(of: searchTerm, options: .caseInsensitive) != nil }
            // Get the recipes who's instructions match and aren't in the first group
            let instructionsMatch = self.allRecipes.filter { $0.instructions.range(of: searchTerm, options: .caseInsensitive) != nil && namesMatch.index(of: $0) == nil }
            
            // Add them together and put them in the filtered array
            self.filteredRecipes = namesMatch + instructionsMatch
        }
        
    }
    
    // MARK: - Variables
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []{
        didSet{
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipeTableViewController?{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var filteredRecipes: [Recipe] = []{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
//        guard let destVC = segue.destination as? RecipeTableViewController else {return}
        if segue.identifier == "RecipeTVC"{
            recipesTableViewController = segue.destination as? RecipeTableViewController
        }
        
    }
    

}
