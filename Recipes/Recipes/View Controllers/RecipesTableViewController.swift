import UIKit

class RecipesTableViewController: UITableViewController {
    
    var recipes: [Recipe] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        
        return cell
    }
    
    //fix segues later
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detailSegue" {
//            guard let destination = segue.destination as? RecipeDetailViewController,
//                let indexPath = tableView.indexPathForSelectedRow else { return }
//            destination.recipe = recipes[indexPath.row]
//        }
        guard let destination = segue.destination as? RecipeDetailViewController else {return}
        if let cell = sender as? UITableViewCell {
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            destination.recipe = recipes[indexPath.row]
        }
    }
}
