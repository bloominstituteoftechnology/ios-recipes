//
//  InstructionsVC.swift
//  Recipes
//
//  Created by Jeffrey Santana on 8/5/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var textView: UITextView!
	
	//MARK: - Properties
	
	var recipe: Recipe?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func updateViews() {
		guard let recipe = recipe else { return }
		
		title = recipe.name
		textView.text = recipe.instructions
	}
	
}
