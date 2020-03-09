//
//  MainViewController.swift
//  Recipes
//
//  Created by Bhawnish Kumar on 3/9/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient: RecipesNetworkClient?
    var allRecipes: [Recipe] = []
    
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
   

}
