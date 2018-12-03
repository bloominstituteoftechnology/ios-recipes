import UIKit
import Foundation

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes \(error)")
                return
            } else {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    private let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func didTapText(_ sender: Any) {
    }
    
    
}
