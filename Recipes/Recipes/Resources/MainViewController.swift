//
//  MainViewController.swift
//  Recipes
//
//  Created by Lambda_School_Loaner_241 on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // Mark:- IBOutlets/Properties
    @IBOutlet weak var recipeTextField: UITextField!
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = [] {
        didSet {
        filteredRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRec
            
        }
    }
    var filteredRec: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRec
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { recipe, error in
            guard error == nil else {
                NSLog(error as! String)
                return
            }
        
            
            guard let rec = recipe else {
                print(" Error loading recipes: The recipes array is nil ")
                return
                
            }
            
            DispatchQueue.main.async {
                self.allRecipes = rec
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recipeTextField(_ sender: Any) {
        resignFirstResponder()
        filteredRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerViewSegue" {
            guard let recipeVC = segue.destination as? RecipesTableViewController else { return  }
            
            recipesTableViewController = recipeVC
            
            
            // part 5 prepare for segue
        }
    }
        
        
        func filteredRecipes(){
            guard let reciTextField = recipeTextField.text, !reciTextField.isEmpty else {
                
                filteredRec = allRecipes
                return
                
                
            }
            
            filteredRec = allRecipes.filter({ (rec: Recipe) -> Bool in
                return (rec.name.range(of: reciTextField, options: .caseInsensitive, range: nil, locale: nil) != nil) ||
                    
                    (rec.instructions.range(of: reciTextField, options: .caseInsensitive, range: nil, locale: nil) != nil)
                
            })
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    

