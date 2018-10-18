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
        didSet{
            recipesTableViewController.recipes = filteredRecipes
            recipesTableViewController.tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textField(_ sender: Any) {
        // text field, call resignFirstResponder()
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (recipes, error) in
            
            if let error = error {
                NSLog( "error \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipesTableViewController else { return }
        if segue.identifier == "containerViewSegue" {
            recipesTableViewController = destination
        }
    }
 
    func filterRecipes(){
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
}
