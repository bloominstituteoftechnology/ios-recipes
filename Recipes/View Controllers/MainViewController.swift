import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var seachTextField: UITextField!
    @IBAction func searchTextField(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.fetchRecipes{ (allRecipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }

            self.allRecipes = allRecipes ?? []
        }
    }
    

    // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedRecipesTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    // Constant for networkClient, set to a new instance of RecipesNetworkClient
    private let networkClient = RecipesNetworkClient()
    
    private var allRecipes: [Recipe] = []
    
    private var recipesTableViewController: RecipesTableViewController?

}
