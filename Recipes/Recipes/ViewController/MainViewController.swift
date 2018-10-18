import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    var filteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            
            if let error = error {
                NSLog("error getting recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewSegue" {
            guard let destinationView = segue.destination as? RecipesTableViewController else { return }

            recipesTableViewController = destinationView
        }
    }
    
    
    
    
    
}
