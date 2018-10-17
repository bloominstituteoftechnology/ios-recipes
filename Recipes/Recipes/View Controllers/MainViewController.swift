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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeSegue" {
            guard let recipeTVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTVC
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            if let search = self.recipe.text, search.count > 0 {
                self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                    return recipe.name.contains(search) || recipe.instructions.contains(search)
                })
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
