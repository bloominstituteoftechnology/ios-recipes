import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func search(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            
            self.allRecipes = recipes ?? []
        }
    }
}
