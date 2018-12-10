
import UIKit

// Only job is to fill out the table view
class RecipesTableViewController: UITableViewController {

    
    // Array of Recipes
    var recipes: [Recipe] = [] {
        
        // Anytime this variable changes...
        didSet {
            //...reload the table view
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    // Cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "namecell", for: indexPath)

        // Display the name of the corresponding Recipe object
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }


    // Prepare for segue between Table View Controller and Detail View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check the segue's identifier
        if segue.identifier == "detailviewsegue" {
            
            // Get the new view controller using segue.destination.
            guard
                let destination = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            // Pass the recipe that corresponds with the indexPath and was tapped to the new view controller.
            let recipe = recipes[indexPath.row]
            destination.recipe = recipe
            
        }

        

    }

}
