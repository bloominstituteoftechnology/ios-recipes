//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Simon Elhoej Steinmejer on 06/08/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

protocol RecipeDetailViewControllerDelegate
{
    func didEditRecipe(on recipe: Recipe, with newInstructions: String)
}

class RecipeDetailViewController: UIViewController
{
    //MARK: - Properties
    
    var delegate: RecipeDetailViewControllerDelegate?
    var originalInstructions: String?
    var recipe: Recipe?
    {
        didSet
        {
            guard let recipe = recipe else { return }
            originalInstructions = recipe.instructions
            updateViews(recipe)
        }
    }
    
    //MARK: - UI Objects
    
    let recipeNameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.sizeToFit()
        
        return label
    }()
    
    let recipeInstructionTextView: UITextView =
    {
        let tv = UITextView()
        tv.isEditable = false
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.layer.cornerRadius = 6
        tv.layer.masksToBounds = true
        
        return tv
    }()
    
    //Makes sure the textview is scrolled to top when loaded
    override func viewDidLayoutSubviews()
    {
        recipeInstructionTextView.setContentOffset(.zero, animated: false)
    }
    
    //MARK: - Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavBar()
        setupUI()
    }
    
    private func updateViews(_ recipe: Recipe)
    {
        recipeNameLabel.text = recipe.name
        recipeInstructionTextView.text = recipe.instructions
    }
    
    private func setupNavBar()
    {
        title = "Instructions"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEditRecipe))
    }
    
    @objc func handleEditRecipe()
    {
        recipeInstructionTextView.isEditable = true
        recipeInstructionTextView.becomeFirstResponder()
        self.recipeInstructionTextView.layer.borderColor = UIColor.black.cgColor
        self.recipeInstructionTextView.layer.borderWidth = 1
        recipeInstructionTextViewBottomAnchor?.constant =  -300
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (completed) in
            
            self.navigationItem.rightBarButtonItem?.action = #selector(self.handleSaveRecipe)
            self.navigationItem.rightBarButtonItem?.title = "Save"
        }
    }
    
    @objc func handleSaveRecipe()
    {
        recipeInstructionTextView.isEditable = false
        recipeInstructionTextView.resignFirstResponder()
        recipeInstructionTextViewBottomAnchor?.constant =  -20
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.view.layoutIfNeeded()
            self.recipeInstructionTextView.layer.borderWidth = 0
            
        }) { (completed) in
            
            self.navigationItem.rightBarButtonItem?.action = #selector(self.handleEditRecipe)
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            
            if self.recipeInstructionTextView.text != self.originalInstructions
            {
                self.delegate?.didEditRecipe(on: self.recipe!, with: self.recipeInstructionTextView.text)
            }
        }
    }
    
    //MARK: - AutoLayout Constraints
    
    var recipeInstructionTextViewBottomAnchor: NSLayoutConstraint?
    
    private func setupUI()
    {
        view.addSubview(recipeNameLabel)
        view.addSubview(recipeInstructionTextView)
        
        recipeNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 0)
        
        recipeInstructionTextView.anchor(top: recipeNameLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 0)
        recipeInstructionTextViewBottomAnchor = recipeInstructionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        recipeInstructionTextViewBottomAnchor?.isActive = true
    }
}






























