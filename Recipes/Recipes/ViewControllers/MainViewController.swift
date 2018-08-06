//
//  MainViewController.swift
//  Recipes
//
//  Created by Simon Elhoej Steinmejer on 06/08/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, RecipesTableViewControllerDelegate
{
    //MARK: - Properties
    
    let fetchedBefore = UserDefaults.standard.bool(forKey: "fetchedBefore")
    let recipesTableViewController = RecipesTableViewController()
    let networkClient = RecipesNetworkClient()
    var recipes = [Recipe]()
    {
        didSet
        {
            recipesTableViewController.recipes = recipes
        }
    }
    var filteredRecipes = [Recipe]()
    {
        didSet
        {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    //MARK: - UI Objects
    
    lazy var searchBar: UISearchBar =
    {
        let sb = UISearchBar()
        sb.delegate = self
        sb.placeholder = "Seach recipes"
        sb.backgroundColor = .white
        
        return sb
    }()
    
    //MARK: - Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        recipesTableViewController.delegate = self
        title = "Recipes"
        setupUI()
        
        fetchRecipes()
    }
    
    private func fetchRecipes()
    {
        if !fetchedBefore
        {
            networkClient.fetchRecipes { (recipes, error) in
                
                if let error = error
                {
                    NSLog("Error fetching recipes: \(error)")
                    return
                }
                
                guard let recipes = recipes else { return }
                self.recipes = recipes
                self.recipesTableViewController.allRecipes = recipes
                PersistenceManager.shared.saveToPersistence(recipes: recipes)
                UserDefaults.standard.set(true, forKey: "fetchedBefore")
            }
        }
        else
        {
            PersistenceManager.shared.loadFromPersistence { (recipes, error) in
                
                if let error = error
                {
                    NSLog("Error fetching recipes from local directory: \(error)")
                    return
                }
                
                guard let recipes = recipes else { return }
                self.recipes = recipes
                recipesTableViewController.allRecipes = recipes
            }
        }
    }
    
    func saveToOriginalArray(recipes: [Recipe])
    {
        self.recipes = recipes
    }
    
    //MARK: - SearchBar Delegate functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty
        {
            searchBar.endEditing(true)
            self.filteredRecipes = self.recipes
            recipesTableViewController.recipes = recipes
        }
        else
        {
            filteredRecipes = self.recipes.filter { (recipe) -> Bool in
                return recipe.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    //MARK: - AutoLayout Constraints
    
    private func setupUI()
    {
        addChildViewController(recipesTableViewController)
        view.addSubview(recipesTableViewController.view)
        view.addSubview(searchBar)
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 40)
        
        recipesTableViewController.view.anchor(top: searchBar.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
}


















