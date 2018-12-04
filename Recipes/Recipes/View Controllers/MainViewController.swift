import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    
    private var recipesTableViewController: RecipesTableViewController! {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    private let networkClient = RecipesNetworkClient()
    private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    private var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var recipeSearchField: UITextField!
    
    //TextField return_key listener
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func search(_ sender: Any) {
        filterRecipes()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // textField delegate
        recipeSearchField.delegate = self
        
        // networking
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error retrieving recipes: \(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }
        
    }
    
    
    func filterRecipes() {
        
        DispatchQueue.main.async {
            //unwrap search term and make sure its not empty string
            if let text = self.recipeSearchField.text, text != "" {
                // if search term is not empty or nil, filter recipe.name and/or recipe.instructions contains search term
                self.filteredRecipes = self.allRecipes.filter({ $0.name.lowercased().contains(text.lowercased()) || $0.instructions.lowercased().contains(text.lowercased())})
                
                //self.filteredRecipes = self.allRecipes //for testing
           }else {
                //if empty or nil, filteredRecipes = allRecipes
                self.filteredRecipes = self.allRecipes
            }
            
        }

    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "EmbedRecipeTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        
        }
        
    }
    

}
