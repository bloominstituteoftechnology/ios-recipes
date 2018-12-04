

import UIKit

class MainViewController: UIViewController {

    let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = [] {
        
        // Whenever the array changes, call the filter function
        didSet {
            filterRecipes()
        }
    }
    
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
    
    var filteredRecipes: [Recipe] = [] {
       
        // Whenever the table changes, update to the most current array of recipes
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            // Check to see if there is text, check to see whether or not the text is empty
            guard let text = self.searchTextFieldOutlet.text,
                text != "" else {
                    self.filteredRecipes = self.allRecipes
                    return
            }
            
            let findRecipes = self.allRecipes.filter ({$0.name.contains(text) || $0.instructions.contains(text)})
            self.filteredRecipes = findRecipes
            
        }
    
        /* MY ORIGINAL CODE
        // Check to see if there is text, check to see whether or not the text is empty
        guard let text = searchTextFieldOutlet.text, !text.isEmpty else {
            filteredRecipes = allRecipes
            return
        }
        
        let findRecipes = allRecipes.filter { (name) -> Bool in
            return text.contains(allRecipes.name || allRecipes.instructions)
            }
        filteredRecipes = allRecipes
        */
    }
    

    var recipesTableViewController: RecipesTableTableViewController? {
        
        // Whenever the table changes, update to the most current array of recipes
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
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
        
        resignFirstResponder()
        
        filterRecipes()
        
    }
    
    @IBOutlet weak var searchTextFieldOutlet: UITextField!
    
}
