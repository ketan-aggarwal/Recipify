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
//    var recipeItems: [CollectionRecipeViewItem]
//    var cuisineItems: [CollectionCuisineViewItem]
}

struct LoadingItem: ItemTypeDashBoardProtocol {
    var itemType: ItemType = .loading
}

enum ItemType {
    case cuisine
    case recipe
    case loading
}

class DashBoardScreenViewModel {

    var dashboardTableItems: [DashBoardTableItem] = []
    //var isLoading: Bool = true
    init(dashboardTableItems: [DashBoardTableItem]) {
            self.dashboardTableItems = dashboardTableItems
        }
   
}


//class DashBoardScreenViewModel {
//    var dashboardTableItems: [DashBoardTableItem]
//
//    init() {
//        // Initially, populate the ViewModel with a loading state item
//        let loadingItem = DashBoardTableItem(dashboardItems: [LoadingItem()], recipeItems: [], cuisineItems: [])
//        self.dashboardTableItems = [loadingItem]
//    }
//
//    func update(with recipeCategories: [[RecipeElement]]) {
//        // Create ViewModel with recipe items when data is available
//        guard !recipeCategories.isEmpty else { return }
//
//        var newDashboardTableItems: [DashBoardTableItem] = []
//
//        // Add cuisine items
//        let cuisines = ["Indian", "Chinese", "American", "Indian", "American"]
//        let cuisineItems = cuisines.map { CollectionCuisineViewItem(title: $0) }
//        let cuisineTableItem = DashBoardTableItem(dashboardItems: cuisineItems, recipeItems: [], cuisineItems: cuisineItems)
//        newDashboardTableItems.append(cuisineTableItem)
//
//        // Add recipe items
//        for categoryRecipes in recipeCategories {
//            var recipeItems: [CollectionRecipeViewItem] = []
//            for recipe in categoryRecipes {
//                let recipeItem = CollectionRecipeViewItem(
//                    id: recipe.id,
//                    title: recipe.title,
//                    image: recipe.image,
//                    readyInMinutes: recipe.readyInMinutes,
//                    healthScore: recipe.healthScore
//                )
//                recipeItems.append(recipeItem)
//            }
//            let tableItem = DashBoardTableItem(dashboardItems: recipeItems, recipeItems: recipeItems, cuisineItems: [])
//            newDashboardTableItems.append(tableItem)
//        }
//
//        // Update the ViewModel with new data
//        self.dashboardTableItems = newDashboardTableItems
//    }
//}



