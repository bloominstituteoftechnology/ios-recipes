//
//  RecipeDatailViewController.swift
//  Recipes
//
//  Created by Sergey Osipyan on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDatailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad
       updateViews()
    }
    
    var recipe: Recipe? {
        didSet {
           updateViews()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    func updateViews() {
        
//        guard let recipe = recipe else { fatalError("no such recipe")
//            return
        let 
        
        let recipe?.name = label.text
        let recipe?.instructions = textView.text
        
        
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



