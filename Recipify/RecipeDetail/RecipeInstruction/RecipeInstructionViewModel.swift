//
//  RecipeInstructionViewModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 06/02/24.
//

import Foundation

struct RecipeInstructions{
    var number: Int
    var step: String
}


class RecipeInstructionViewModel {
    var instructionsList: [RecipeInstructions]
    
    init(instructionsList: [RecipeInstructions]) {
        self.instructionsList = instructionsList
    }
}
