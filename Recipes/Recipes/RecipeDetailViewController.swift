import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

    }
    
    func updateViews(){
        if isViewLoaded {
        guard let recipe = recipe else {return}
        recipeName.text = recipe.name
        recipeDetails.text = recipe.instructions
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
