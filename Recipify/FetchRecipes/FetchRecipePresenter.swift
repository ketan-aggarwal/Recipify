//
//  FetchRecipePresenter.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 08/02/24.
//

import Foundation

protocol FetchRecipePresenterLogic {
    func presentRecipe(searchRecipes: [RecipeElement])
}


class FetchRecipePresenter: FetchRecipePresenterLogic {
    
    weak var viewController: FetchRecipeViewController?
    
    func presentRecipe(searchRecipes: [RecipeElement]) {
        guard let viewModel = createViewModel(from: searchRecipes) else {
            return
        }
        viewController?.displayRecipes(viewModel: viewModel)
    }
    
    func createViewModel(from searchRecipes: [RecipeElement]) -> FetchRecipeViewModel? {
        let searchList: [SearchRecipe] = searchRecipes.map { recipe in
            
           return SearchRecipe(id: recipe.id,
                         title: recipe.title,
                         image: recipe.image,
                         readyInMinutes: recipe.readyInMinutes,
                         healthScore: recipe.healthScore)
        }
        let viewModel = FetchRecipeViewModel(searchList: searchList)
        return viewModel
    }
}

