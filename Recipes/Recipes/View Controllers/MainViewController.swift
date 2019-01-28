import UIKit

class MainViewController: UIViewController {
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                    NSLog(error)
                }
            } catch {
                
            }
        
        
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as?  RecipeDetailViewController else { return }
        
        if segue.identifier == "DetailSegue" {
            recipesTableViewController = destinationVC
        }
    }
 

}
