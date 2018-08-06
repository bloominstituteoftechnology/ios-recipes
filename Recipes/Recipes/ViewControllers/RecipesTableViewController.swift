//
//  RecipesTableViewController.swift
//  Recipes
//
//  Created by Simon Elhoej Steinmejer on 06/08/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

protocol RecipesTableViewControllerDelegate
{
    func saveToOriginalArray(recipes: [Recipe])
}

class RecipesTableViewController: UITableViewController, RecipeDetailViewControllerDelegate
{
    //MARK: - Properties
    
    var delegate: RecipesTableViewControllerDelegate?
    let cellId = "recipeCell"
    var recipes = [Recipe]()
    {
        didSet
        {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var allRecipes = [Recipe]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    func didEditRecipe(on recipe: Recipe, with newInstructions: String)
    {
        if let index = allRecipes.index(of: recipe)
        {
            allRecipes[index].instructions = newInstructions
            PersistenceManager.shared.saveToPersistence(recipes: allRecipes)
            delegate?.saveToOriginalArray(recipes: allRecipes)
        }
    }

    //MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let recipe = recipes[indexPath.row]
        let recipeDetailViewController = RecipeDetailViewController()
        recipeDetailViewController.recipe = recipe
        recipeDetailViewController.delegate = self
        navigationController?.pushViewController(recipeDetailViewController, animated: true)
    }
    
}
