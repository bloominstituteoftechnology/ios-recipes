import UIKit
import Foundation

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error fetching recipes \(error)")
                return
            } else {
                self.allRecipes = recipes ?? []
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the segue identifier in our storyboard is "RecipeSegue"
        // we're going to set the destination to the RecipesTableViewController
        if segue.identifier == "RecipeSegue" {
            let recipesTableVC = segue.destination as? RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    private var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    private let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func didTapText(_ sender: Any) {
        
        textField.resignFirstResponder()
        
        filterRecipes()
    }
    
    func filterRecipes() {
        DispatchQueue.main.async {
            guard let text = self.textField?.text, !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            
            self.filteredRecipes = self.allRecipes.filter({ (recipe) -> Bool in
                recipe.name.contains(text) || recipe.instructions.contains(text)
            })
            
            
        }
    
        
    }
    
    


}
