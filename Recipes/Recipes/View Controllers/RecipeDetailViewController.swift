import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeView: UITextView!
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            recipeName.text = recipe.name
            recipeView.text = recipe.instructions 
        }
    }
}
