//
//  MainViewController.swift
//  Recipes
//
//  Created by Gavin Murphy on 10/29/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var recipedSearchTextFiedl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Action Handlers

    @IBAction func recipeSearched(_ sender: Any) {
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
