import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textField: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        if let recipe = recipe {
            nameLabel.text = recipe.name
            textField.text = recipe.instructions
        }
    
    }

}
