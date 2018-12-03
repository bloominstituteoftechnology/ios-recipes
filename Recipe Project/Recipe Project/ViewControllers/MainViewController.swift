import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func textFieldSearch(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
// in closures you always have to declare self
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error getting recipes: \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededRecipeTableView" {
            let recipesTableVC = segue.destination as! RecipesTableViewController
            recipesTableViewController = recipesTableVC
        }
    }
    
    private var allRecipes: [Recipe] = [] 
    private let networkClient = RecipesNetworkClient()
    private var recipesTableViewController: RecipesTableViewController
    private var filteredREcipes: [Recipe] = []
    
    func filterRecipes() {
        guard let text = textField.text, !text.isEmpty else { return }
        
        
    }
    
}
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "EmbedStudentsTableView" {
//        let studentsTableVC = segue.destination as! StudentsTableViewController
//        studentsTableViewController = studentsTableVC
//    }
//}
