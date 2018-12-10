import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe = Recipe? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var instructionView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else {return}
            recipeLabel.text = recipe.name
            instructionView.text = recipe.instructions
        }
    }
}
