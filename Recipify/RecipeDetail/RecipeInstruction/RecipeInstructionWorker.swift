//
//  RecipeInstructioWorker.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import Foundation

protocol  RecipeInstructioWorkingLogic {
    func getRecipeInstruction(ID: Int, completion : @escaping ([[Step]]?) -> Void)
}

class RecipeInstructionWorker: RecipeInstructioWorkingLogic {
    
    func getRecipeInstruction(ID: Int, completion: @escaping ([[Step]]?) -> Void) {
        let interpString = String(ID)
        let urlString = "https://api.spoonacular.com/recipes/\(interpString)/analyzedInstructions?apiKey=cca46e1551784aef8290868015fd7b83"
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
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    var stepsArray: [[Step]] = []
                    for dict in jsonArray ?? [] {
                        if let stepsDict = dict["steps"] as? [[String: Any]] {
                            let steps = stepsDict.compactMap { stepDict in
                                return try? JSONDecoder().decode(Step.self, from: JSONSerialization.data(withJSONObject: stepDict))
                            }
                            stepsArray.append(steps)
                        }
                    }
                    completion(stepsArray)
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
