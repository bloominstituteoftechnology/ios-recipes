import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    var allRecipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
            filterRecipes()
        }
    }
    
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
        DispatchQueue.main.async {
            if let search = self.searchField.text, search.count > 0 {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in return recipe.name.contains(search) || recipe.instructions.contains(search)})
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        guard let mainDestination = segue.destination as?
            RecipeTableViewController else { return }
        
        recipesTableViewController = mainDestination
    }
}
