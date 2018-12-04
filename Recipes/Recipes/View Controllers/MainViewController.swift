import UIKit

class MainViewController: UIViewController {
    
    let reuseIdentifier = "RecipeCell"
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
    
    
    @IBAction func search(_ sender: Any) {
        recipeSearchField.resignFirstResponder()
        filterRecipes()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkClient.fetchRecipes { (allRecipes, error) in
            if let error = error {
                NSLog("Error retrieving recipes: \(error)")
                return
            }
            
            self.allRecipes = allRecipes ?? []
        }
        
    }
    
    
    func filterRecipes() {
        //unwrap search term and make sure its not empty string
        if let text = recipeSearchField.text, !text.isEmpty {
            // TODO: if search term is not empty or nil, filter recipe.name and/or recipe.instructions contains search term
            filteredRecipes = allRecipes //for testing
        }else {
            //if empty or nil, filteredRecipes = allRecipes
            filteredRecipes = allRecipes
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
