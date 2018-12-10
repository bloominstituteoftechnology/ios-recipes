
import UIKit

class RecipeDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var instructionsView: UITextView!
    
    // Instance of our Model - Recipe
    var recipe: Recipe? {
        
        // Anytime this property changes...
        didSet {
            
            //...Update the label and view
            updateViews()
        }
    }
    

    func updateViews() {
        
        // Check that the view is loaded
        guard isViewLoaded else { return }
        
        // Ensure we have a recipe to present
        if let recipe = recipe {
            
            // Populate label and view
            nameLabel.text = recipe.name
            instructionsView.text = recipe.instructions
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Update label and view with corresponding recipe
        updateViews()
    }

}
