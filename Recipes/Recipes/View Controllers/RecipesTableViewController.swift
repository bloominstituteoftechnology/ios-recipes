import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
        
        return cell
    }
    
    //fix segues later
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let destinationVC = segue.destination as? RecipeDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.recipe = recipes[indexPath.row]
        }
    }
}
