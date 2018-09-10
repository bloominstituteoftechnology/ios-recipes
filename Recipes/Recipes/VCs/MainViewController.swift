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
        if (searchTextField.text?.isEmpty)!{
            filteredRecipes = allRecipes
        } else {
            let textToSearch = searchTextField.text
            filteredRecipes = allRecipes.filter({$0.name == textToSearch})
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
