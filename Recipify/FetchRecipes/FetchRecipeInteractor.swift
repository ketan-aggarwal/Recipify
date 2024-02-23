//
//  FetchRecipeInteractor.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 08/02/24.
//

import Foundation

protocol FetchRecipeBusinessLogic{
    func fetchRecipes(inputString: String)
}

protocol FetchRecipeDataStore {
    var searchRecipes: [RecipeElement] {get set}
}

class FetchRecipeInteractor: FetchRecipeBusinessLogic, FetchRecipeDataStore {
   
    var searchRecipes: [RecipeElement] = []
    var worker: FetchRecipeWorker?
    var presenter: FetchRecipePresenter?
    
    func fetchRecipes(inputString: String) {
        worker?.fetchRecipe(inputString: inputString){ [weak self]  searchRecipes in
            self?.searchRecipes = searchRecipes ?? []
            self?.presenter?.presentRecipe(searchRecipes: self?.searchRecipes ?? [])
        }
    }
    
    
}
