import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func textFieldSearch(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
// in closures you always have to declare self
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    private var allRecipes: [Recipe] = [] 
    private let networkClient = RecipesNetworkClient()
    
}
