import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe? {
        //didSet gets called once recipe property is set
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    @IBOutlet weak var recipeView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        if isViewLoaded {
        guard let recipe = recipe else {return}
        recipeLabel.text = recipe.name
        recipeView.text = recipe.instructions
        }
    }
}
