import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeInstructions: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        if let recipe = recipe {
            recipeName.text = recipe.name
            recipeDescription.text = recipe.instructions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

}
