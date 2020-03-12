//
//  MainViewController.swift
//  Recipes
//
//  Created by Waseem Idelbi on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: -IBOutlets and IBActions-
    
    @IBOutlet var searchTextField: UITextField!
    
    @IBAction func searchFieldAction(_ sender: UITextField) {
        
    }
    
    
   //MARK: -Properties-
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    
    
    //MARK: -Methods-
    
    //stuff
    

} //End of class
