import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe  = recipe else { return }
            textLabel.text = recipe.name
            textView.text = recipe.instructions
        }
    }
}
