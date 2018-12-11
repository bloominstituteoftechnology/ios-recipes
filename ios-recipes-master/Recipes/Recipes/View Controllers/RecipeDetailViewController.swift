import UIKit

class RecipeDetailViewController: UIViewController {

    // Connections from the text view and label
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeInstructions: UITextView!
    
    // creating a variable set to the recipe class
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    // Updates the view as the array is changed
    func updateViews() {
        // checks if the view was loaded
        guard isViewLoaded else { return }
        // if successful, we unwrap recipe and set the text view and label to their respective recipe instructions and names
        if let recipe = recipe {
            recipeName.text = recipe.name
            recipeInstructions.text = recipe.instructions
        }
    }
    
    // Make sure the update appears on the user's end.
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

}
