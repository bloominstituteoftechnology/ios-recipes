import UIKit

class MainViewController: UIViewController {
    
    var networkClient: RecipesNetworkClient
    
    var allRecipes: [Recipe] = []
    
    var recipesTableViewController: RecipesTableViewController?
    
    
    @IBOutlet weak var recipeText: UITextField!
    
    @IBAction func recipeTextAction(_ sender: Any) {
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Network Error 234423\(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }
    }
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipesTableViewController {
            recipesTableViewController = destinationVC
        }
    }

}
