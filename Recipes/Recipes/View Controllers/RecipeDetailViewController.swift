import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        recipeLabel.text = recipe?.name
        textView.text = recipe?.instructions
        
        // Part 2 question 2
     //   RecipeDetailViewController
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
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
