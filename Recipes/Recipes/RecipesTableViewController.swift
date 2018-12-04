import UIKit

class RecipesTableViewController: UITableViewController {
    
    let reuseIdentifier = "recipeCell"
    
    var recipes: [Recipe] = [] {
        //didSet is called when the recipes property is set
        didSet {
            //reloading data needs to happen on the Main thread
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
        //let recipe = recipes[indexPath.row]
        //cell.textLabel?.text = recipe.name
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeCellSegue" {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        
        guard let recipeDestination = segue.destination as?
                RecipeDetailViewController else { return }
            
        recipeDestination.recipe = recipes[indexPath.row]
        }
    }
}
