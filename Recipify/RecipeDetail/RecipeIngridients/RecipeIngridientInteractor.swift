//
//  RecipeIngridientInteractor.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import Foundation

protocol RecipeIngridientBusinessLogic {
    func getRecipeIngridients()
}

protocol RecipeIngridientDataStore {
   
    var recipeIngirdients : [ExtendedIngredient] {get set}
    var itemID: Int {get set}
}

class RecipeIngridientInteractor: RecipeIngridientBusinessLogic, RecipeIngridientDataStore  {
    
    var itemID: Int
    var recipeIngirdients: [ExtendedIngredient] = []
    var worker: RecipeIngridientWorker?
    var presenter: RecipeIngridientPresenter?
    
    init(itemID:Int) {
        self.itemID = itemID
        print("RecipeIngid\(itemID)")
    }
     
    func getRecipeIngridients() {
        worker?.getRecipeIngridients(ID: itemID) { [weak self] ingridients in
            self?.recipeIngirdients = ingridients ??  []
            print("march\(self!.recipeIngirdients[0])")
            self?.presenter?.presentFetchedIngridients(recipeIngirdients: self?.recipeIngirdients ?? [])
        }
       
    }
    
    
}
