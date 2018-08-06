import Foundation
import UIKit

class RecipeDetailVC:UIViewController
{
	var recipe:Recipe!

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var contentLabel: UITextView!
	override func viewWillAppear(_ animated: Bool)
	{
		nameLabel.text = recipe.name
		contentLabel.text = recipe.instructions
	}
}
