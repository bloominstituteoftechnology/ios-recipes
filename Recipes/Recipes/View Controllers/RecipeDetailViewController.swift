//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Bree Jeune on 3/12/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//




/*
 
 private var filteredAndSortedStudents: [Student] = [] {
 // another way to do it is private var filteredAndSortedStudents = [Student]()
 
 didSet {
     DispatchQueue.main.async {
         self.tableView.reloadData()
     }
     
 }
 
 
 */

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?

  
    @IBOutlet weak var recipeDetailTextLabel: UILabel!
    
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        
    

}
    
    func updateViews() {
            guard let recipe = recipe, isViewLoaded else { return }
            recipeDetailTextLabel?.text = recipe.name
            recipeDetailTextView?.text = recipe.instructions
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
