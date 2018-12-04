
import UIKit

class RecipeDetailViewController: UIViewController {

    // Gives Detail View Controller a reference to to the model
    // This is instead of Singleton - Singleton does it once and you can use it anywhere.
    // This is an instance just for this controller
    var recipe: Recipe? {
        
        // Whenever the property changes, call the updateViews function to update the label + text view
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        
        // If it's loaded...
        guard isViewLoaded else { return }
        
        // Ensure we have a recipe to present - If recipe is not nil, nothing will be assigned
        if let recipe = recipe {
            
            // Populate the label and text view
            recipeNameLabel.text = recipe.name
            
            recipeInstructionsTextView.text = recipe.instructions
        }
    }

  
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
    
}
