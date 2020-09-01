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
    
    //TextField listener
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
        
        // MARK: - networking
        
        //check to see if recipes.json exists
        var loadedRecipes: [Recipe] = []
        let diskURL = networkClient.getCachesURL()
        let fileURL = diskURL.appendingPathComponent("recipes.json")
        let fileExists = FileManager().fileExists(atPath: fileURL.path)
        //let loadedRecipes = networkClient.getRecipesFromDisk()
        if fileExists {
            loadedRecipes = networkClient.getRecipesFromDisk()
            self.allRecipes = loadedRecipes
        }else { loadedRecipes = [] } // <-- for data source test
        
        if self.allRecipes.isEmpty {
            //if it doesnt exist fetch data from the API
            networkClient.fetchRecipes { (allRecipes, error) in
                if let error = error {
                    NSLog("Error retrieving recipes: \(error)")
                    return
                }

                self.allRecipes = allRecipes ?? []
                //save the self.allRecipes to recipes.json in caches directory
                self.networkClient.saveRecipesToDisk(recipes: self.allRecipes)
            }
        }
        
        //test for data source
        if loadedRecipes.isEmpty {
            print("Recipes Loaded from API")
        }else {
            print("Recipes Loaded from Caches Directory")
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
