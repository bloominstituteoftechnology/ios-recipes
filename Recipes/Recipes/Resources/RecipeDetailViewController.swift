import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    
    
    func updateViews() {
        recipeLabel.text = recipe?.name
        recipeText.text = recipe?.instructions
    }
    
    // is view loaded? part 2.2
    
    
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
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
