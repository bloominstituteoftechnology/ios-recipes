//
//  MainViewController.swift
//  Recipes
//
//  Created by John Pitts on 5/13/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient?.fetchRecipes(completion: <#T##([Recipe]?, Error?) -> Void#>)
    }
    
    @IBAction func searchTextFieldExitted(_ sender: Any) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet var searchTextField: UITextField!
    let networkClient: RecipesNetworkClient?
    var allRecipes: [Recipe] = []
    
}
