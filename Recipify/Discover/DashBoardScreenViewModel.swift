//
//  DashBoardScreenViewModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 29/01/24.
//

import Foundation


protocol ItemTypeDashBoardProtocol {
    var itemType: ItemType {get}
}

struct CollectionRecipeViewItem : ItemTypeDashBoardProtocol{
    var itemType: ItemType = .recipe
    
    var id: Int?
    var title: String?
    var image: String?
    var readyInMinutes: Int?
    var healthScore: Int?
}

struct CollectionCuisineViewItem : ItemTypeDashBoardProtocol {
    var itemType: ItemType = .cuisine
    var title: String?
}

struct DashBoardTableItem {
    var dashboardItems: [ItemTypeDashBoardProtocol]
    var recipeItems: [CollectionRecipeViewItem]
    var cuisineItems: [CollectionCuisineViewItem]
}


enum ItemType {
    case cuisine
    case recipe
    case loading
}

class DashBoardScreenViewModel {
    
    var dashboardTableItems: [DashBoardTableItem] = []
    init(dashboardTableItems: [DashBoardTableItem]) {
            self.dashboardTableItems = dashboardTableItems
        }
    
    
    
}
