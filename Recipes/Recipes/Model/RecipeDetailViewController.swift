import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe? {
        didSet{
            updateView()
        }
    }
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView(){
        guard let recipe = recipe else { return }
        recipeNameLabel.text = recipe.name
        recipeText.text = recipe.instructions
        
        
    }
}
