import Foundation

protocol DiscoverRecipesWorkerLogic {
    func fetchRecipes(query: String, completion: @escaping ([RecipeElement]?) -> Void)
}

class DiscoverRecipesWorker: DiscoverRecipesWorkerLogic {
    func fetchRecipes(query: String, completion: @escaping ([RecipeElement]?) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&number=4&apiKey=fa2ddf68cccb4977a68420d8829eded1&instructionsRequired=true&addRecipeInformation=true"
        print("Recipes\(urlString)")
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching recipes: \(error)")
                completion(nil)
                return
            }

            if let data = data {
                // Dispatch to a background queue to simulate a delay
                DispatchQueue.global().async {
                    // Simulate a 2-second delay
                    Thread.sleep(forTimeInterval: 1)
                    
                    DispatchQueue.main.async {
                        do {
                            let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                            completion(recipes.results)
                        } catch {
                            print("Error decoding JSON: \(error)")
                            completion(nil)
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}




//class DiscoverRecipesWorker: DiscoverRecipesWorkerLogic {
//    func fetchRecipes(query: String, completion: @escaping ([RecipeElement]?) -> Void) {
//
//        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&number=4&apiKey=638f9e512b0d416baff747e8325f5914&instructionsRequired=true&addRecipeInformation=true"
//        print("Recipes\(urlString)")
//        guard let url = URL(string: urlString) else {
//
//            completion(nil)
//            return
//        }
//
//        // Create a URLSession data task
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            // Handle errors
//            if let error = error {
//                print("Error fetching recipes: \(error)")
//                completion(nil)
//                return
//            }
//
//            if let data = data {
//                do {
//                    let recipes = try JSONDecoder().decode(Recipes.self, from: data)
//                    completion(recipes.results)
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }.resume()
//    }
//}
