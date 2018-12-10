import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        recipeLabel.text = recipe?.name
        recipeText.text = recipe?.instructions
    }
    
    // is view loaded? part 2.2
    
    
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
}
