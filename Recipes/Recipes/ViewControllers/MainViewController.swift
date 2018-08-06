//
//  MainViewController.swift
//  Recipes
//
//  Created by Carolyn Lea on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var searchTextField: UITextField!
    var recipesTableViewController: RecipesTableViewController?
    {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = []
    {
        didSet {
            self.recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error
            {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }

    func filterRecipes()
    {
        DispatchQueue.main.async {
            guard let searchTerm = self.searchTextField.text else {return}
            if searchTerm == ""
            {
                self.filteredRecipes = self.allRecipes
                print(self.filteredRecipes)
            }
            else
            {
                self.filteredRecipes = self.allRecipes.filter{$0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)}
                print(self.filteredRecipes)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        view.endEditing(true)
        filterRecipes()
        recipesTableViewController?.tableView.reloadData()
        return true
    }
    
 
    @IBAction func search(_ sender: Any)
    {
        view.endEditing(true)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//    {
//        if let textFieldString = textField.text, let swtRange = Range(range, in: textFieldString) {
//            
//            let fullString = textFieldString.replacingCharacters(in: swtRange, with: string)
//            
//            print("FullString: \(fullString)")
//        }
//        
//        return true
//    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "EmbedRecipeTableView"
        {
            let recipeTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipeTableVC
        }
    }
    

}
