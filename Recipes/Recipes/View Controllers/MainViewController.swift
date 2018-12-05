

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error geting recipes: \(error)")
                return
        }
            self.allRecipes = recipes ?? []
        }
    }
   private let NetworkClient = RecipesNetworkClient()
   private var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
   private var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
           recipesTableViewController?.tableView.reloadData()
        }
    }
  private  var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = self.filteredRecipes
        }
    }
  
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func text(_ sender: Any) {
        textField.resignFirstResponder()
        filterRecipes()
    
    }
    func filterRecipes() {
        
        DispatchQueue.main.async {
            guard let text = self.textField?.text, !text.isEmpty else {
                self.filteredRecipes = self.allRecipes
                return
            }
            // need func
            self.filteredRecipes  = self.allRecipes.filter({ (string) -> Bool in
                return string.name.lowercased().contains(text) || string.instructions.lowercased().contains(text)
            })
            
        }
    }
    
    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == "transfer" {
 let recipeTableVC = segue.destination as! RecipesTableViewController
 recipesTableViewController = recipeTableVC
    }
}

}
