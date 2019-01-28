//
//  MainViewController.swift
//  Recipes
//
//  Created by Michael Flowers on 1/28/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //call the fetchRecipes method. if there is no error set the value of allRecipes to recipes returned in this completion closure. This way the tableView will populate with all recipes returned
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching the recipes from the network call: \(error.localizedDescription)")
            }
            //no errors so set the value of allRecipes to the ones we've gotten back
            self.allRecipes = recipes ?? []
        }
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
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
