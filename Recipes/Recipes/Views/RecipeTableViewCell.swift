//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by alfredo on 1/14/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - IBOutlets
    
    @IBOutlet weak var recipeLabel: UILabel!
 
    //MARK: - Properties
    
    var recipeName: String? {
        didSet{
            updateViews()
        }
    }

    //MARK: - Methods
    
    func updateViews(){
        recipeLabel.text = recipeName 
    }
}
