//
//  DetailViewController.swift
//  Recipe
//
//  Created by Diante Lewis-Jolley on 5/6/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       updateViews()
    }

    func updateViews() {
        guard let recipe = recipe else { return }
        recipeTitle.text = recipe.name
        textView.text = recipe.instructions
    }
    

    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var textView: UITextView!


}
