import Foundation

struct RecipesNetworkClient {
    
    static let recipesURL = URL(string: "https://cookbook.vapor.cloud/recipes")!
    
    func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: RecipesNetworkClient.recipesURL) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                completion(recipes, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    // Helper method to get a URL to the user's caches directory
    func getCachesURL() -> URL {
        if let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
    
    func saveRecipesToDisk(recipes: [Recipe]) {
        // create a URL for caches/recipes.json
        let url = getCachesURL().appendingPathComponent("recipes.json")
        // endcode our [Recipe] data to JSON Data
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(recipes)
            // write data to the specified url
            try data.write(to: url, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getRecipesFromDisk() -> [Recipe] {
        // create a url for caches/recipes.json
        let url = getCachesURL().appendingPathComponent("recipes.json")
        let decoder = JSONDecoder()
        do {
            // retrieve the data on the file in this path (if there is any)
            let data = try Data(contentsOf: url, options: [])
            // decode the array of [Recipe] from this JSON Data
            let recipes = try decoder.decode([Recipe].self, from: data)
            return recipes
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
