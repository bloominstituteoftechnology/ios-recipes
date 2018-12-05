import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var recipes: [Recipe] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name

        return cell
    }




    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? RecipeDetailViewController else { return }
        if let cell = sender as? UITableViewCell {
            guard let indexpath = tableView.indexPath(for: cell) else { return }
            destination.recipe = recipes[indexpath.row]
        }
    }


}
