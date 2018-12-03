
import UIKit

class RecipeDetailViewController: UIViewController {

    // Gives Detail View Controller a reference to to the model
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        recipeNameLabel.text = recipe?.name
        
        recipeInstructionsTextView.text = recipe?.instructions
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
    
}
