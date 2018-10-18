import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews(){
        if isViewLoaded{
            guard let recipe = recipe else { return }
            recipeNameLabel.text = recipe.name
            recipeText.text = recipe.instructions
        }
    
    }
}
