import UIKit

class RecipesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
        var recipes: [Recipe] = [] {
            didSet{
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

}
