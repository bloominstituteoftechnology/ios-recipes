import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
   
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
        
        func updateViews() {
            if isViewLoaded {
                guard let recipe = recipe else { return }
                recipeLabel.text = recipe.name
                textView.text = recipe.instructions
            }
    }
    
    
}
