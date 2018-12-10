import UIKit

class RecipesTableViewController: UITableViewController {
    
    let reuseIdentifier = "recipeCell"
    
    private var recipeDetailViewController: RecipeDetailViewController!
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        guard let destinationVC = segue.destination as? RecipeDetailViewController else { return }
        if let cell = sender as? UITableViewCell {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            destinationVC.recipe = recipes[indexPath.row]
        }
    }
}
