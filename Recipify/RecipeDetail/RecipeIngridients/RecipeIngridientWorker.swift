//
//  RecipeIngridientWorker.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import Foundation

protocol RecipeIngridientWorkingLogic {
    func getRecipeIngridients(ID: Int, completion: @escaping ([ExtendedIngredient]?) -> Void )
}

class  RecipeIngridientWorker: RecipeIngridientWorkingLogic {
    
    func getRecipeIngridients(ID: Int, completion: @escaping ([ExtendedIngredient]?) -> Void ){
        let interpString = String(ID)
        let urlString = "https://api.spoonacular.com/recipes/\(interpString)/information?includeNutrition=false&apiKey=126f25b751f24b71bcf1206d60ce4592"
        print("Recipes\(urlString)")
        guard let url = URL(string: urlString) else {
            
            completion(nil)
            return
        }
        
        // Create a URLSession data task
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Handle errors
            if let error = error {
                print("Error fetching recipes: \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let recipes = try JSONDecoder().decode(RecipeDetail.self, from: data)
                    completion(recipes.extendedIngredients)
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

