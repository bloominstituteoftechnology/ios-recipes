import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recipeLabel: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            if let recipe = recipe {
                nameLabel.text = recipe.name
                recipeLabel.text = recipe.instructions
            }
        }
    }
    
}
