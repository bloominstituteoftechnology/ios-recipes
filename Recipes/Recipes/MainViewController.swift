import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            
            self.allRecipes = recipes ?? []
        }

    }
    
    @IBOutlet weak var searchBar: UITextField!
    
    private var recipesTableViewController: RecipesTableViewController?

    @IBAction func search(_ sender: Any) {
    }
    
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = []
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
         var filteredRecipes: [Recipe] = []
        
        filterRecipes() {
            
        }
    }
    

}
