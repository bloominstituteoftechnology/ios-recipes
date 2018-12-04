import UIKit

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    

    @IBOutlet weak var recipeNameLabel: UILabel!
    
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews(){
        
        if isViewLoaded {
            if let recipe = recipe {
                
                recipeNameLabel.text = recipe.name
                recipeTextView.text = recipe.instructions
            }

        }

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
