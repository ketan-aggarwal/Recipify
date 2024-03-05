//
//  RecipeIngridientViewModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 06/02/24.
//

import Foundation

struct RecipeIngridients {
    var amount: Double?
    var name: String?
    var unit: String?
}


class RecipeIngridientViewModel {
    var ingridientList: [RecipeIngridients] // Adjusted property name to adhere to Swift naming conventions
    
    init(ingridientList: [RecipeIngridients]) {
        self.ingridientList = ingridientList
    }
}
