import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            recipeTitle?.text = recipe.name
            recipeTextView?.text = recipe.instructions
        }
    }
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

        // Do any additional setup after loading the view.
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
