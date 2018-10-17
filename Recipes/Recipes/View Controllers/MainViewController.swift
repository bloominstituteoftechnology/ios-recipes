import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    @IBOutlet weak var textField: UITextField!
    
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData() //....needed
        }
    }
    
    @IBAction func editField(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            DispatchQueue.main.async {
               self.allRecipes = recipes ?? []
            }
        }
    }
    
    func filterRecipes() {
        guard let searchName = textField.text else { return }
        if searchName == "" {
            filteredRecipes = allRecipes
        } else {
            filteredRecipes = allRecipes.filter({ $0.name.contains(searchName) || $0.instructions.contains(searchName) })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue" {
            recipesTableViewController = (segue.destination as? RecipesTableViewController)
        }
    }
    
    
}
