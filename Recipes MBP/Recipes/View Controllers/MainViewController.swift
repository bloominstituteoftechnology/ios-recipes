
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    @IBAction func searchComplete(_ sender: Any) {
        
        resignFirstResponder()
        
        filterRecipes()
    }
    
    // Instance of the network client
    let networkClient = RecipesNetworkClient()
    
    // Array of Recipes
    var allRecipes: [Recipe] = [] {
        // Anytime the property changes...
        didSet {
            ///...call the filterRecipes function
            filterRecipes()
        }
    }
    
    // Instance of the table view controller
    var recipesTableViewController: RecipesTableViewController? {
        
        // Anytime the property changes...
        didSet {
            //...set the recipes in the table view controller to the filtered recipes
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        
        // Anytime the property changes...
        didSet {
           //...set the recipes in the table view controller to the filtered recipes
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes { (allRecipes, error) in
            
            // In this closure, check to see if an error happened, and log it if it did
            if let error = error {
                NSLog("Error getting students: \(error)")
                return
            }
            
            // Set the value of the array to the recipes returned in this completion closure
            self.allRecipes = allRecipes ?? []
        }
    }
    

    // Prepare for segue SHOWS data from the table view in the content view of the main view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Check for the embed segue's identifier
        if segue.identifier == "tableviewsegue" {
          
            // Set the recipesTableViewController as the segue's destination
            let recipesTVC = segue.destination as! RecipesTableViewController
            
            // Pass the selected object to the new view controller.
            recipesTableViewController = recipesTVC
        }
    }
    
    func filterRecipes() {
        
        // This involves UIKit, so we must perform on the main queue
        DispatchQueue.main.async {
            
            // Check to see if there is text, and make sure it isn't an empty string
            guard let text = self.searchField.text,
                text != "" else {
                    // If no search term, display all of the recipes
                    self.filteredRecipes = self.allRecipes
                    return
            }
            
            // Filter allRecipes array to see if the name of the recipe or the instructions of the recipe contain the text entered by the user
            let matchingRecipes = self.allRecipes.filter ({$0.name.contains(text.lowercased()) || $0.instructions.contains(text.lowercased())})
            
            // Set the value of filteredRecipes to the results of the filter
            self.filteredRecipes = matchingRecipes
        }
    }
}
