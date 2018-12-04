
import UIKit

class RecipeDatailViewController: UIViewController {

    static let reuseIdentifier = "cell"
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
        if isViewLoaded == true {
        guard let recipe = recipe else { fatalError("no such recipe")
        }
        
        label.text = recipe.name
        textView.text = recipe.instructions
        
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



