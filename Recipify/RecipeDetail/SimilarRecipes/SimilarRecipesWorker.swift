//
//  SimilarRecipesWorker.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 07/02/24.
//

import Foundation

protocol SimilarRecipeWokerLogic {
    func fetchSimilarRecipes(recipeID: Int, completion: @escaping ([Recipe]?) -> Void)
}

class SimilarRecipesWorker: SimilarRecipeWokerLogic {
    func fetchSimilarRecipes(recipeID: Int, completion: @escaping ([Recipe]?) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(recipeID)/similar?number=6&apiKey=fa2ddf68cccb4977a68420d8829eded1"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Handle errors
            if let error = error {
                print("Error fetching recipes: \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    completion(recipes)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}

