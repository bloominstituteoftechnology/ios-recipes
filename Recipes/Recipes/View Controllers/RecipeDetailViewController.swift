//
//  DetailViewController.swift
//  Recipes
//
//  Created by Austin Cole on 12/3/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITextViewDelegate {
    
     let mainVC = MainViewController()

    override func viewDidLoad() {
        mainVC.loadData()
        textView.delegate = self
        super.viewDidLoad()
        if textLabel.text == "Label" {
            updateViews()}

        // Do any additional setup after loading the view.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        mainVC.saveData()
    }

    func updateViews() {
        mainVC.loadData()
        if isViewLoaded {
        textLabel.text = recipe?.name
        textView.text = recipe?.instructions
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

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
}
