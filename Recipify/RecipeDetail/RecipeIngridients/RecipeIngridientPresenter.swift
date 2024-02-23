//
//  RecipeIngridientPresenter.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 06/02/24.
//

import Foundation

protocol RecipeIngridientPresenterLogic {
    func presentFetchedIngridients(recipeIngirdients: [ExtendedIngredient])
}

class RecipeIngridientPresenter: RecipeIngridientPresenterLogic {
    
    weak var viewController : RecipeIngrdientsViewController?
    
    func presentFetchedIngridients(recipeIngirdients: [ExtendedIngredient]) {
        if let viewModel = createViewModel(from : recipeIngirdients){
            viewController?.displayRecipeIngredients(viewModel: viewModel)
        }
    }
    
    func createViewModel(from recipeIngirdients: [ExtendedIngredient]) -> RecipeIngridientViewModel? {
        guard !recipeIngirdients.isEmpty else {
            return nil
        }
        
        let ingredientList: [RecipeIngridients] = recipeIngirdients.map { ingredient in
            return RecipeIngridients(amount: ingredient.amount, name: ingredient.name)
        }
        
      
        let viewModel = RecipeIngridientViewModel(ingridientList: ingredientList)
        return viewModel
    }

    
}
