import UIKit

class RecipesTableViewController: UITableViewController {
    
    let reuseIdentifier = "recipeCell"
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }
}
