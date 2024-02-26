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

        let formattedInput = inputString.replacingOccurrences(of: " ", with: "+").replacingOccurrences(of: ",", with: "+")
        let url = "https://api.spoonacular.com/recipes/complexSearch?query=\(formattedInput)&number=10&apiKey=fa2ddf68cccb4977a68420d8829eded1&instructionsRequired=true&addRecipeInformation=true"
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
    
    
    
    
