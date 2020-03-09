//
//  MainViewController.swift
//  Recipes
//
//  Created by Bhawnish Kumar on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var recipesTableViewController: RecipesTableViewController?
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error load students: \(error)")
                return
            }
            if let recipes = recipes {
            DispatchQueue.main.async {
                self.allRecipes = recipes
            }

        }
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
    
    private func filterRecipes() {
        
        let filter = TrackType(rawValue: filterSelector.selectedSegmentIndex) ?? .none
        let sort = SortNames(rawValue: sortSelector.selectedSegmentIndex) ?? .firstName
         
        studentController.filter(with: filter, sortedBy: sort) { students in
        self.filteredAndSortedStudents = students
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
        guard let newRecipeVC = segue.destination as? RecipesTableViewController else {return }
        // Get the new view controller using segue.destination.
//            guard let indexPath =
//            let recipe = recipes[indexPath.row]
            
        }


}
    
}
    

    
