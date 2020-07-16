//
//  DetailVC.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

protocol RecipesDetailVCDelegate : AnyObject {
  func didReceivedNewRecipes(recipe: Recipe)
}

class RecipesDetailViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textView: UITextView!
  
  weak var delegate : RecipesDetailVCDelegate?
  
  var recipe: Recipe? {
    didSet {
      updateViews()
    }
  }
  //MARK:- Life Cycle
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    guard var newRecipe = recipe else { return }
    newRecipe = Recipe(name: self.label.text ?? "", instructions: self.textView.text)
    delegate?.didReceivedNewRecipes(recipe: newRecipe)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textView.delegate = self
    updateViews()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    
  }
  
  @objc func edit() {
    
    let ac = UIAlertController(title: "Edit recipes?", message: nil, preferredStyle: .alert)
    ac.addTextField { (textField) in
      textField.text = self.label.text
    }
    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
      let textField = ac.textFields![0]
      self.label.text = textField.text
      self.textView.isEditable.toggle()
      
    }))
    ac.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    present(ac, animated: true, completion: nil)
  }
  
  
  private func updateViews() {
    if isViewLoaded {
      if let recipe = recipe {
        label.text = recipe.name
        textView.text = recipe.instructions
      }
    }
  }
}
