import UIKit
import Foundation

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theRecipeCell", for: indexPath)
        
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Destination for the segue is the RecipeDetailViewController
        guard let destination = segue.destination as? RecipeDetailViewController else { return }
        // If the cells sender is from the TableViewCell, it'll be on the indexPath for the selected cell.
        if let cell = sender as? UITableViewCell {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            destination.recipe = recipes[indexPath.row]
        }
    
}
}
