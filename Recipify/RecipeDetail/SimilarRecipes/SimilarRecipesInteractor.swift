//
//  SimilarRecipesInteractor.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 07/02/24.
//

import Foundation

protocol SimilarRecipesBusinessLogic{
//    func fetchSimilarRecipes(recipeID: Int)
    func fetchSimilarRecipes()
}

protocol SimilarRecipesDataStore{
    var recipes:[Recipe] {get set}
}

class SimilarRecipesInteractor: SimilarRecipesBusinessLogic{
   
    var itemID: Int
    var similarRecipes:[Recipe]?
    var worker: SimilarRecipesWorker?
    var presenter:SimilarRecipesPresenter?
    
    init(itemID:Int) {
        self.itemID = itemID
        print("SimilarRecipeId\(itemID)")
    }
    
    func fetchSimilarRecipes() {
        worker?.fetchSimilarRecipes(recipeID: itemID){ [weak self] similarRecipes in
            self?.similarRecipes = similarRecipes ?? []
            self?.presenter?.presentSimilarRecipes(similarRecipes: self?.similarRecipes ?? [])
        }
    }
    
    
}
