//
//  RecipeModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 29/01/24.
//

import Foundation

struct Cuisine {
    var title: String
}


struct Recipes: Codable {
    let results: [RecipeElement]?
    let offset, number, totalResults: Int?
}

struct RecipeElement: Codable {
    
    var id: Int?
    var title: String?
    var calories: Int?
    var image: String?
    var imageType: String?
    var cuisines: [String]?
    var readyInMinutes, cookingMinutes: Int?
    var averageRating: Double?
    var diets: [String]?
    var healthScore: Int?
    var servings: Int?
    var veryPopular: Bool
    var veryHealthy: Bool
}
