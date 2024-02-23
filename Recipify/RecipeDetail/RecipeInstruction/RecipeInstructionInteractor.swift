//
//  RecipeInstructionInteractor.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
////
///
///i
//
import Foundation

protocol RecipeInstructionBusinessLogic {
    func getRecipeInstruction()
}

protocol RecipeInstructionDataStore {
    var recipeInstructions: [[Step]] { get set } // Update to handle array of arrays of Step
}

class RecipeInstructionInteractor: RecipeInstructionBusinessLogic, RecipeInstructionDataStore {
    
    var itemID: Int
    var recipeInstructions: [[Step]] = [] 
    var worker: RecipeInstructionWorker?
    var presenter: RecipeInstructionPresenter?
    
    init(itemID:Int) {
        self.itemID = itemID
        print("RecipeInst\(itemID)")
    }
    
    func getRecipeInstruction() {
        worker?.getRecipeInstruction(ID: itemID) { [weak self] fetchedInstructions in
            guard let fetchedInstructions = fetchedInstructions else {
                
                return
            }
            self?.recipeInstructions = fetchedInstructions
            // Call presenter to present fetched instructions
            self?.presenter?.presentFetchedInstructions(recipeInstructions: fetchedInstructions)
        }
    }
}

