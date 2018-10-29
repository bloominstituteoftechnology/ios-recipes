import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?

    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeDetails: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateViews(){
        guard let recipe = Recipe(name:String, instructions: String )
        
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
