import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes = [Recipe]() {
        didSet {
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes = [Recipe]() {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
            recipesTableViewController.tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var recipeText: UITextField!
    
    @IBAction func recipeTextAction(_ sender: Any) {
        
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.recipeText.text, !text.isEmpty {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.contains(text) || recipe.instructions.contains(text) } )
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Network Error 234423\(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }
    }
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RecipesTableViewController {
            recipesTableViewController = destinationVC
        }
    }

}
