//
//  DetailVC.swift
//  Recipes
//
//  Created by Nick Nguyen on 2/10/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

protocol RecipesDetailVCDelegate : AnyObject {
    func didReceivedNewRecipes(name: String, instruction: String)
}

class RecipesDetailVC: UIViewController, UITextViewDelegate
{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    weak var delegate : RecipesDetailVCDelegate?
    
    
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
       //
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
           self.delegate?.didReceivedNewRecipes(name: self.label.text ?? "", instruction: self.textView.text)
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
      
    }
    
    @objc func edit() {
        print("Hello")
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
