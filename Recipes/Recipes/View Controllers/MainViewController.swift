//
//  MainViewController.swift
//  Recipes
//
//  Created by Moses Robinson on 1/21/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchRecipe(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: - Properties
    
    @IBOutlet weak var searchRecipesField: UITextField!
    
}
