import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController?
    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let mainDestination = segue.destination as? RecipesTableViewController else {return}
            
            RecipesTableViewController = mainDestination
        }
    }
}
