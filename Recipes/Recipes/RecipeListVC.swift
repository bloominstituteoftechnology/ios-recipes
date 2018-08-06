import Foundation
import UIKit

class RecipeListVC:UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
{
	var recipes:[Recipe] = [
		Recipe(name:"TestRecipe A", instructions:"Eat it"),
		Recipe(name:"TestRecipe B", instructions:"DON'T Eat it")]
	var filteredRecipes:[Recipe] = []

	@IBOutlet weak var filterField: UITextField!
	@IBOutlet weak var table: UITableView!

	let networkClient = RecipesNetworkClient()

	func filterRecipes(_ filter:String)
	{
		if filter == "" {
			filteredRecipes = recipes
		} else {
			filteredRecipes = recipes.filter {
				$0.name.lowercased().range(of:filter) != nil
			}
		}

		DispatchQueue.main.async {
			self.table.reloadData()
		}
	}

	override func viewDidLoad()
	{
		filterRecipes(filterField.text ?? "")
		networkClient.fetchRecipes(completion: { (recipes, error) in
			if error != nil {
				NSLog("There was an error")
				return
			}

			if recipes == nil {
				NSLog("Downloaded recipes were nil!")
				return
			}
			self.recipes = recipes ?? []
			self.filterRecipes("")
		})
		table.dataSource = self
		table.delegate = self
		filterField.delegate = self
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	@IBAction func filterRecipesOnEnd(_ sender: Any)
	{
		filterRecipes(filterField.text ?? "")
		resignFirstResponder()
	}

	@IBAction func filterRecipeWhileTyping(_ sender: Any)
	{
		filterRecipes(filterField.text ?? "")
	}

	override func viewWillAppear(_ animated: Bool)
	{
		table.reloadData()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let dest = segue.destination as? RecipeDetailVC {
			guard let p = table.indexPathForSelectedRow else {return}
			dest.recipe = filteredRecipes[p.row]
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return filteredRecipes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell")
		cell?.textLabel!.text = filteredRecipes[indexPath.row].name
		return cell!
	}


}

