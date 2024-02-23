//
//  SimilarRecipesViewModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 07/02/24.
//

import Foundation


struct SimilarRecipe{
    let id: Int
    let imageType: String
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String?
}

class SimilarRecipeViewModel {
    var similarRecipesList: [SimilarRecipe]
    
    init(similarRecipesList: [SimilarRecipe]) {
        self.similarRecipesList = similarRecipesList
    }
}
