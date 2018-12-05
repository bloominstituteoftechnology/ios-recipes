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
        // 1. Create a URL for documents-caches/posts.json
        let url = getCachesURL().appendingPathComponent("recipes.json")
        // 2. Endcode our [Recipe] data to JSON Data
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(recipes)
            // 3. Write this data to the url specified in step 1
            try data.write(to: url, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getRecipesFromDisk() -> [Recipe] {
        // 1. Create a url for documents-caches/posts.json
        let url = getCachesURL().appendingPathComponent("recipes.json")
        let decoder = JSONDecoder()
        do {
            // 2. Retrieve the data on the file in this path (if there is any)
            let data = try Data(contentsOf: url, options: [])
            // 3. Decode the array of Recipe from this Data
            let recipes = try decoder.decode([Recipe].self, from: data)
            return recipes
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
