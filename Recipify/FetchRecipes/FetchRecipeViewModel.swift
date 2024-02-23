//
//  FetchRecipeViewModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 08/02/24.
//

import Foundation

struct SearchRecipe {
    var id: Int?
    var title: String?
    var image: String?
    var readyInMinutes: Int?
    var healthScore: Int?
}

class FetchRecipeViewModel{
    
    var searchList: [SearchRecipe]
    
    init(searchList: [SearchRecipe]) {
        self.searchList = searchList
    }
}
