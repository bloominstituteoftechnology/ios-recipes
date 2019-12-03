//
//  MainViewController.swift
//  Recipes
//
//  Created by Zack Larsen on 12/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        networkClient.fetchRecipes(completion: NSLog()
        var recipesTableViewController: RecipeDetailViewController?
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchField(_ sender: Any) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination 
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
