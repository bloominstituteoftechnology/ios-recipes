import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            
            if let error = error {
                NSLog("error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldTapped(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipesTableViewController else { return }
        
        recipesTableViewController = destination
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let searchTerm = self.textField.text?.lowercased() else { return }
            if searchTerm.isEmpty {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter {$0.name.lowercased().contains(searchTerm) || $0.instructions.lowercased().contains(searchTerm)}
            }
        }
    }
}
