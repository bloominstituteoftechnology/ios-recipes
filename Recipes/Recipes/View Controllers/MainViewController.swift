

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the array of recipes when MainViewController first loads
        networkClient.fetchRecipes { (allRecipes, error) in
            
            // In closure, check if error happened
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            
            // use nil coalescing to unwrap
            self.allRecipes = allRecipes ?? []
        }
    }
    
    var filteredRecipes: [Recipe] = []
    
    func filterRecipes() {
        
        if let textFieldSearch
        
    }
    

    var recipesTableViewController: RecipesTableTableViewController?
    
    // Prepare for segue from Main View Controller to Table View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedRecipesTableView" {
        
            // Get the new view controller using segue.destination
            let recipesTableVC = segue.destination as! RecipesTableTableViewController
        
            // Pass the selected object to the new view controller
            recipesTableViewController = recipesTableVC
        }
    }
 
    @IBAction func textFieldSearch(_ sender: Any) {
    }
    
    @IBOutlet weak var searchTextFieldOutlet: UITextField!
    
}
