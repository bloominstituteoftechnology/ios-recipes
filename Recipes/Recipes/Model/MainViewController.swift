import UIKit

class MainViewController: UIViewController {
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = []
    
    var recipesTableviewController: RecipesTableViewController?
    
    var filteredRecipes: [Recipe] = []
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textField(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipe, error) in
            // if let error is error NSLOG if no error will = allRecipes
        }
// call networkClient's fetchRecipes
       
                

    }
    
// prepare for segue In the prepare(for segue: ...), check for the embed segue's identifier. If it is, set the recipesTableViewController variable to the segue's destination. You will need to cast the view controller as the correct subclass
                
    
// create func call filterRecipes()
}
