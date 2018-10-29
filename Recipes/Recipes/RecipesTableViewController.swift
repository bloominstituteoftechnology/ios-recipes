import UIKit

class RecipesTableViewController: UITableViewController {

    var recipes: [Recipe] = []{
        didSet{
            DispatchQueue.main.async{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name
       
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeCellSegue"{
            guard let recipeDestination = segue.destination as?
                RecipeDetailViewController else { return }
            
            //need explaination here
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            recipeDestination.recipe = recipes[indexPath.row]
        
        }
    }
}
