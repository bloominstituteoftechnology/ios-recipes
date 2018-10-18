import UIKit

class RecipeDetailViewController: UIViewController {
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var recipe: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        if isViewLoaded {
            guard let recipe = recipe else { return }
            labelText.text = recipe.name
            textView.text = recipe.instructions
        }
    }
    
//     func updateViews(){
//        if isViewLoaded{
//            guard let name = recipe?.name,
//                let instructions = recipe?.instructions else {return}
//
//            recipeLabel.text = name
//            instructionsTextView.text = instructions
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    
    }
    

}
