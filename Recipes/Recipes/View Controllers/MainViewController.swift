import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error:  \(error)")
                return
            }
    
            self.allRecipes = recipes ?? []
        }
    }
    
    let networkClient = RecipesNetworkClient()
    
    var filteredRecipes = [Recipe] () {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
            recipesTableViewController.tableView.reloadData()
        }
    }
    
    var recipesTableViewController: RecipeTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.textField.text, !text.isEmpty {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.contains(text) || recipe.instructions.contains(text)
                })
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }

    @IBOutlet weak var textField: UITextView!
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as?  RecipeTableViewController else { return }
        
        if segue.identifier == "TableViewSegue" {
            recipesTableViewController = destinationVC
        }
    }
 

}
