//
//  RecipeInstructionPresenter.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 06/02/24.
//

import Foundation

protocol RecipeInstructionPresenterLogic {
    func presentFetchedInstructions(recipeInstructions: [[Step]])
}

class RecipeInstructionPresenter: RecipeInstructionPresenterLogic {
    
    weak var viewController: RecipeInstructionViewController?
    
    func presentFetchedInstructions(recipeInstructions: [[Step]]) {
        // Flatten the array of arrays of steps into a single array of steps
        let allSteps = recipeInstructions.flatMap { $0 }
        let viewModel = createViewModel(from: allSteps)
        viewController?.displayInstructions(viewModel: viewModel)
    }
    
    func createViewModel(from recipeInstructions: [Step]) -> RecipeInstructionViewModel {
        let instructionsList = recipeInstructions.map { step in
            return RecipeInstructions(number: step.number, step: step.step)
        }
        return RecipeInstructionViewModel(instructionsList: instructionsList)
    }
}

