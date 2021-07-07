import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            recipeTitle?.text = recipe.name
            recipeTextView?.text = recipe.instructions
        }
    }
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
}
