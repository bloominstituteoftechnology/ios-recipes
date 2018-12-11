import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func searchRecipe(_ sender: Any) {
        // call resignFirstResponder() on the text field & call filterRecipes()
        textField.resignFirstResponder()
        filterRecipes()
    }
    
    // Set the constant to an instance of RNC.
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the networkClient's fetchRecipes{ } method
        
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            
            // Setting self.allRecipes to what we receive from the network client
            // This is setting the ViewController's property called `allRecipes` (self.allRecipes) to the `allRecipes` that is returned from the network call, which is defined in the parameters of the closure.
            self.allRecipes = allRecipes ?? []
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check for the embed segue's identifier.
        if segue.identifier == "EmbedTableView" {
            // This isn't related to the variable above/below, so be sure to rename it.
            let recipesTableVC = segue.destination as? RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    // Both variable below ensure that the table view controller
    // has the most current array of recipes, filtered or not.

    // This will hold a reference to the embedded table view controller
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // Search results array
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    // filter recipes function that uses text from the text field
    // It must:
    // unwrap the search term and check if it's empty
    // if empty, display all the recipes
    // if there isn't a search term, show all of the recipes by default
    // if the search term is non-empty, use the filter higher order function the allRecipes array
    // the filter should look through both the name and instructions provided to see if it contains the search term.
    // Plug the filter method into filteredRecipes
    func filterRecipes() {
        // Updates the UI on the main queue so that the user can see the changes
        DispatchQueue.main.async {
            // check if the textField text is nil
            guard let searchTerm = self.textField.text, !searchTerm.isEmpty
                // return all the recipes if it is nil
                else { return self.filteredRecipes = self.allRecipes }
                // filter the allRecipes array and store those values into filteredRecipes[]
                self.filteredRecipes = self.allRecipes.filter({
                    $0.name.lowercased().contains(searchTerm.lowercased()) || $0.instructions.lowercased().contains(searchTerm.lowercased())
                })
        }
    }
    
    
}
