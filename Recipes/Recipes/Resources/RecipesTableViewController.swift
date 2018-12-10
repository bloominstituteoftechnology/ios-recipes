import UIKit

class RecipesTableViewController: UITableViewController {
    
    let reuseIdentifier = "recipeCell"
    
    private var recipeDetailViewController: RecipeDetailViewController!
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                // reload table coad
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
       // cell.?.text = recipe.instructions

        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let destinationVC = segue.destination as? RecipeDetailViewController {
            recipeDetailViewController = destinationVC
        }
        // Pass the selected object to the new view controller.
    }
    

}
