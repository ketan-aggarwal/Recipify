//
//  FetchRecipeWorker.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 08/02/24.
//

import Foundation

protocol FetchRecipeWorkerLogic{
    func fetchRecipe(inputString: String, completion: @escaping ([RecipeElement]?) -> Void)
}


class FetchRecipeWorker: FetchRecipeWorkerLogic {
    
    
    func fetchRecipe(inputString: String, completion: @escaping ([RecipeElement]?) -> Void) {
//        let cleanQuery = (inputString).replacingOccurrences(of: ",", with: "")
//        let interpString = (cleanQuery).replacingOccurrences(of: " ", with: ",+")
        
        let url = "https://api.spoonacular.com/recipes/complexSearch?query=\(inputString)&number=10&apiKey=03192ddb1d3f453384a79f85ba59234f&instructionsRequired=true&addRecipeInformation=true"
        print(url)
        guard let url = URL(string: url) else {
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
                    let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                    completion(recipes.results)
            
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
    
    
    
    
