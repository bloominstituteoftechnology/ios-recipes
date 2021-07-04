import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            if let recipes = recipes {
                self.allRecipes = recipes
            }
        }
    
    }
    
        var filteredRecipes: [Recipe] = []
        
        func filterRecipes() {
            guard let searchTerm = self.searchBar.text, !searchTerm.isEmpty else {
                self.filteredRecipes = self.allRecipes
                
                let searchRecipes = self.allRecipes.filter ({$0.name.contains(text) || $0.instructions.contains(text)})
                self.filteredRecipes = searchRecipes

                
            }
    }
        


    
    @IBOutlet weak var searchBar: UITextField!
    
    private var recipesTableViewController: RecipesTableViewController?

    @IBAction func search(_ sender: Any) {
    }
    
    private let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
        
    }

}
