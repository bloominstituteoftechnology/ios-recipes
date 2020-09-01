//
//  DetailVC.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textView: UITextView!
  
  var recipe: Recipe?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    label.text = recipe!.name
    textView.text = recipe!.instructions
  }
 
}
