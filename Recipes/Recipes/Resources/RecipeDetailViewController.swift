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
        
        recipeLabel.text = recipe.name
        recipeText.text = recipe.instructions
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
}

