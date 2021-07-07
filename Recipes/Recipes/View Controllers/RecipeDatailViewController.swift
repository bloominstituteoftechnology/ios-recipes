
import UIKit

class RecipeDatailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       updateViews()
        
    }
    
    var recipe: Recipe? {
        didSet {
           updateViews()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    func updateViews() {
        if isViewLoaded {
        guard let recipe = recipe else { fatalError("no such recipe") }
        
        label.text = recipe.name
        textView.text = recipe.instructions
        
        }
        }
}



