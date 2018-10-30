import UIKit

class MainViewController: UIViewController {
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []{
        didSet{
            recipesTableViewController.recipes = filteredRecipes
            filterRecipes()
        }
    }
    
    var recipesTableViewController: RecipesTableViewController! {
        didSet{
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = []{
        didSet{
            recipesTableViewController.recipes = filteredRecipes
            recipesTableViewController.tableView.reloadData()
        }
    }

    @IBOutlet weak var recipeTextField: UITextField!
    
    @IBAction func recipeTextField(_ sender: Any) {
        recipeTextField.resignFirstResponder()
        filterRecipes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkClient.fetchRecipes { (success, error) in
            
            if let error = error {
                NSLog("error \(error)")
                return
            }
            self.allRecipes = success ?? []
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue"{
        guard let mainDestination = segue.destination as? RecipesTableViewController else { return }
            
            //why if I put main first it has an error
            recipesTableViewController = mainDestination
        }
    }
    func filterRecipes(){
         DispatchQueue.main.async {
              if let search = self.recipeTextField.text, search.count > 0 {
                 self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                     return recipe.name.contains(search) || recipe.instructions.contains(search)
                        })
                 } else {
                    self.filteredRecipes = self.allRecipes
                }
            }
        }
    }
