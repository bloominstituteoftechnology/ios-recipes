import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    @IBOutlet weak var textField: UITextField!
    
    var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
            recipesTableViewController.tableView.reloadData()
        }
    }
    
    @IBAction func editField(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
            //            DispatchQueue.main.async {
            //               self.allRecipes = recipes ?? []
            //            }
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.textField.text, !text.isEmpty {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.lowercased().contains(text) || recipe.instructions.lowercased().contains(text)
                })
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipesTableViewController else { return }
        if segue.identifier == "cellSegue" {
            recipesTableViewController = destination
        }
    }
}
