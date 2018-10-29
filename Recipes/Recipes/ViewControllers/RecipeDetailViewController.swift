import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            
            recipeNameLabel.text = recipe.name
            instructionsTextView.text = recipe.instructions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
}
