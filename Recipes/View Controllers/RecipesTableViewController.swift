import UIKit

class RecipesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)

        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowRecipesDetailView" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("Could not originate from source.") }
            guard let destination = segue.destination as? RecipesDetailViewController else { fatalError("Could not reach destination.")}
        
            let recipe = recipes[indexPath.row]
            
            destination.recipe = recipe
        }
    }

    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
}
