//
//  MainViewController.swift
//  Recipes
//
//  Created by Cameron Dunn on 1/22/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes : [Recipe] = []{
        didSet{
            filterRecipes()
        }
    }
    var recipesTableViewController : RecipesTableViewController?
    var filteredRecipes: [Recipe] = []{
        didSet{
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error{
                NSLog("There was an error: \(error)")
            }else{
                self.allRecipes = recipes!
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func EditingEnded(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    func filterRecipes(){
        DispatchQueue.main.async {
            if(self.textField.text != nil && self.textField.text != ""){
                self.filteredRecipes = self.allRecipes.filter { $0.name.contains("\(self.textField!.text ?? "")")  }
            }else{
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TableViewSegue"){
            recipesTableViewController = (segue.destination as! RecipesTableViewController)
        }
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
