//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by alfredo on 1/14/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        updateViews()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextView!
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews(){
        guard self.isViewLoaded else { return }
        guard let recipe_ = recipe else { return }
        
        label.text = recipe_.name
        textField.text = recipe_.instructions
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
