//
//  RecipeTableViewCell.swift
//  Recipes
//
//  Created by Michael on 1/13/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateViews() {
        
    }
    
}
