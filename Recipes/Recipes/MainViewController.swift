import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
    var recipesTableViewController: RecipesTableViewController?
    
    var filteredRecipes: [Recipe] = []
    
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
    
    func filterRecipes() {
        if let search = searchField.text, search.count > 0 {
            filteredRecipes = allRecipes.filter {
                $0.name.contains(search) || $0.instructions.contains(search) }
        } else {
            filteredRecipes = allRecipes
            }
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let mainDestination = segue.destination as? RecipesTableViewController else {return}
            
            recipesTableViewController = mainDestination
        }
    }
}
