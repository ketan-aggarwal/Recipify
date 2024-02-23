//
//  SimilarRecipesPresenter.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 07/02/24.
//

import Foundation

protocol SimilarRecipesPresntationLogic{
    func presentSimilarRecipes(similarRecipes: [Recipe])
}

class SimilarRecipesPresenter: SimilarRecipesPresntationLogic {
    
    weak var viewController: SimilarRecipesViewController?
    
    func presentSimilarRecipes(similarRecipes: [Recipe]) {
           guard let viewModel = createViewModel(from: similarRecipes) else {
               return
           }
           viewController?.displaySimilarRecipes(viewModel: viewModel)
       }
    
    func createViewModel(from similarRecipes: [Recipe]) -> SimilarRecipeViewModel? {
        guard !similarRecipes.isEmpty else {
                   return nil
               }
               
               let similarRecipesList = similarRecipes.map { recipe in
                   SimilarRecipe(id: recipe.id,
                                 imageType: recipe.imageType,
                                 title: recipe.title,
                                 readyInMinutes: recipe.readyInMinutes,
                                 servings: recipe.servings,
                                 sourceUrl: recipe.sourceUrl)
               }
               
               return SimilarRecipeViewModel(similarRecipesList: similarRecipesList)
           }
}
