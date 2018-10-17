import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    @IBOutlet weak var recipe: UITextField!
    @IBAction func recipeTapped(_ sender: Any) {
        recipe.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (success, error) in
            if let error = error {
                NSLog("Error uploading recipes: \(error)")
                return
            }
            self.allRecipes = success ?? []
        }
    }
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }

    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.recipe.text, !text.isEmpty {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.contains(text) || recipe.instructions.contains(text)
                })
                    } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipe" {
            guard let recipeTVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTVC
        }
    }

}
