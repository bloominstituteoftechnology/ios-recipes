import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var recipeLabel: UITextView!
    
    var: Recipe? {
        didSet {
            updateViews()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        //nameLabel.text = recipe.name
       //recipeLabel.text = recipe.instructions
    }
    
}
