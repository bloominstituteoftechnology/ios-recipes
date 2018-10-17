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
            guard let searchName = self.textField.text else { return }
            if searchName == "" {
                self.filteredRecipes = self.allRecipes
            } else {
                self.filteredRecipes = self.allRecipes.filter({ $0.name.contains(searchName) || $0.instructions.contains(searchName) })
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
