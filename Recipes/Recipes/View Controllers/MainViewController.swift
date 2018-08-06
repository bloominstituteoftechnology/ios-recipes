//
//  MainViewController.swift
//  Recipes
//
//  Created by De MicheliStefano on 06.08.18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func searchRecipes(_ sender: Any) {
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "EmbedRecipesTableView" {
            
        }
        
    }
    
    // MARK: - Properties

    @IBOutlet weak var searchTextField: UITextField!
}
