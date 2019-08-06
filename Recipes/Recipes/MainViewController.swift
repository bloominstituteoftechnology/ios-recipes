//
//  MainViewController.swift
//  Recipes
//
//  Created by Bradley Yin on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []{
        didSet{
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = []{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var recipesTableViewController: RecipesTableViewController?{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error{
                NSLog("error networking \(error)")
                return
            }else{
                guard let recipes = recipes else { return }
                DispatchQueue.main.async {
                    self.allRecipes = recipes
                }
                
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewEmbedSegue"{
            guard let destination = segue.destination as? RecipesTableViewController else {return}
            recipesTableViewController = destination
        }
    }
    @IBAction func endOnExit(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    func filterRecipes(){
        guard let searchString = textField.text, !searchString.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        filteredRecipes = allRecipes.filter({$0.name.contains(searchString) || $0.instructions.contains(searchString)})
        
    }
    
}
