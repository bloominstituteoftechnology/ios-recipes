import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
            recipesTableViewController.tableView.reloadData()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func search(_ sender: Any) {
        searchField.resignFirstResponder()
        filterRecipes()
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
       // if segue.identifier == "recipeSegue" {
        guard let mainDestination = segue.destination as? RecipesTableViewController else { return }
        
        recipesTableViewController = mainDestination
        
    }
}
