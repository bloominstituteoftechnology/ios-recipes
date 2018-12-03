import UIKit
import Foundation

class RecipeDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var recipe: Recipe?
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var recipeText: UITextView!
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            label.text = recipe.name
            recipeText.text = recipe.instructions
        }        
    }
    
}
