//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Cameron Dunn on 1/22/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    var recipe : Recipe?{
        didSet{
            updateViews()
        }
    }
    
    func updateViews(){
        if(self.isViewLoaded){
        guard let loadedRecipe = recipe else {return}
        label.text = loadedRecipe.name
        textView.text = loadedRecipe.instructions
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
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
