
import UIKit

class RecipesTableTableViewController: UITableViewController {

    var recipe: Recipe?
    
    var recipes: [Recipe] = [] {
        
        // Whenever the property changes, call the reloadData function
        didSet {
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return recipes.count
    }

    
    // Contents of cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipecell", for: indexPath)

        // Configure the cell...
        // Put the name in the cell
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
    
    
    // Reference so that the Detail View Controller has access to the Detail Table View Controller
    private var recipeDetailTableViewController: RecipeDetailViewController!
    
    
    // Prepare for segue from Table View Controller to Detail View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a property that references the Detail View Controler
        if segue.identifier == "ShowDetailView"  {
            
            // fetch index path and view controller
            guard
                let destination = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            // Pass the recipe from the recipes array that corresponds with the indexPath (cell that was tapped)
            let recipe = recipes[indexPath.row]
            destination.recipe = recipe
            
        }
    }
}
