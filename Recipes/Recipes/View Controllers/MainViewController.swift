//
//  MainViewController.swift
//  Recipes
//
//  Created by Andrew Liao on 8/6/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadToPersistentStore()
        if allRecipes.isEmpty {
            print("fetching all recipes")
            networkClient.fetchRecipes { (recipe, error) in
                if let error = error {
                    NSLog("Error: \(error)")
                }
                guard let recipe = recipe else {return}
                self.allRecipes = recipe
                self.saveToPersistentStore()
            }
        }
    }
    
    func filterRecipes(){
        DispatchQueue.main.async {
            
            if let searchTerm = self.searchLabel.text,
                searchTerm != "" {
                self.filteredRecipes = self.allRecipes.filter{$0.name.contains(searchTerm) || $0.instructions.contains(searchTerm)}
            } else{
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    @IBAction func editingDidEnd(_ sender: Any) {
        searchLabel.resignFirstResponder()
        filterRecipes()
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableVC"{
            let destinationVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = destinationVC
            destinationVC.mainViewController = self
        }
    }
    //MARK: - Persistence
    
    func saveToPersistentStore(){
        guard let fileURL = fileURL else {return}
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(allRecipes)
            try data.write(to: fileURL)
        } catch {
            NSLog("Error encountered while encoding")
        }
        
    }
    
    func loadToPersistentStore(){
        let fm = FileManager.default
        guard let fileURL = fileURL,
            fm.fileExists(atPath: fileURL.path),
            let data = fm.contents(atPath: fileURL.path) else {return}
        
        let decoder = PropertyListDecoder()
        do {
            allRecipes = try decoder.decode([Recipe].self, from: data)
        } catch  {
            NSLog("Error encountered while decoding")
        }
        
    }
    
    // MARK: CRUD Properties
    func update(recipe: Recipe, instructions: String){
        guard let index = allRecipes.index(of:recipe) else {return}
        allRecipes[index].instructions = instructions
        saveToPersistentStore()
    }
    
    // MARK: - Properties
    @IBOutlet weak var searchLabel: UITextField!
    let networkClient = RecipesNetworkClient()
    var allRecipes = [Recipe]() {
        didSet{
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController?{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes = [Recipe](){
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
            
        }
    }
    
    private var fileURL:URL? {
        let fm = FileManager.default
        guard let documentDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {fatalError("Error with document directory")}
        
        let filename = "recipes.plist"
        
        return documentDir.appendingPathComponent(filename)
    }
    
}
