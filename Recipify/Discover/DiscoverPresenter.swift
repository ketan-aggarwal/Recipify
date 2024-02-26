import Foundation

class DashBoardPresenter {
    weak var viewController: DiscoverViewContoller?


        func presentFetchedData(recipeCategories: [[RecipeElement]]) {
            print("Received recipe categories:")

            for (index, category) in recipeCategories.enumerated() {
                print("Category \(index + 1):")

                for recipeElement in category {
                    print("  - Recipe Element: \(recipeElement)")
                }
            }

            if let viewModel = createViewModel(from: recipeCategories) {
                viewController?.displayDashBoardData(viewModel: viewModel)

            }
        }
    
   
    private func createViewModel(from recipeCategories: [[RecipeElement]]) -> DashBoardScreenViewModel? {
        guard !recipeCategories.isEmpty else {
            return nil
        }
        print("Elements in recipeCategories: \(recipeCategories.count)")

        var dashboardTableItems: [DashBoardTableItem] = []


        var cuisines: [String] = []
        cuisines = ["Indian", "Chinese", "American", "Indian", "American"]

        let cuisineItems = cuisines.map { CollectionCuisineViewItem(title: $0) }
       // let cuisineTableItem = DashBoardTableItem(dashboardItems: cuisineItems, recipeItems: [], cuisineItems: cuisineItems)
        let cuisineTableItem = DashBoardTableItem(dashboardItems: cuisineItems)
           dashboardTableItems.append(cuisineTableItem)


        for index in 1..<recipeCategories.count + 1 {
            let categoryRecipes = recipeCategories[index-1]

            var recipeItems: [CollectionRecipeViewItem] = []

            for recipe in categoryRecipes {
                let recipeItem = CollectionRecipeViewItem(

                    id: recipe.id,
                    title: recipe.title,
                    image: recipe.image,
                    readyInMinutes: recipe.readyInMinutes,
                    healthScore: recipe.healthScore
                )
                recipeItems.append(recipeItem)
            }

//            let tableItem = DashBoardTableItem(dashboardItems: recipeItems, recipeItems: recipeItems, cuisineItems: [])
            let tableItem = DashBoardTableItem(dashboardItems: recipeItems)
            dashboardTableItems.append(tableItem)
        }



        print("Total items in dashboard:\(dashboardTableItems.count)")

        let viewModel = DashBoardScreenViewModel(dashboardTableItems: dashboardTableItems)

        return viewModel
    }


    
    func presentFilteredData(isHealthy: Bool, isPopular: Bool, recipeCategories: [[RecipeElement]])  {
       
        guard !recipeCategories.isEmpty else {
            return
        }

        var filteredDashboardItems: [DashBoardTableItem] = []


        let cuisines = ["Indian", "Chinese", "American", "Indian", "American"]
        let cuisineItems = cuisines.map { CollectionCuisineViewItem(title: $0) }

      //  let cuisineTableItem = DashBoardTableItem(dashboardItems: cuisineItems, recipeItems: [], cuisineItems: cuisineItems)
        let cuisineTableItem = DashBoardTableItem(dashboardItems: cuisineItems)
        filteredDashboardItems.append(cuisineTableItem)

        print("filtered\(recipeCategories[0])")

        for categoryRecipes in recipeCategories {
            var filteredRecipeItems: [CollectionRecipeViewItem] = []

            for recipe in categoryRecipes {
                if (isHealthy && recipe.readyInMinutes ?? 30 <= 30) {

                    let recipeItem = CollectionRecipeViewItem(
                        id: recipe.id,
                        title: recipe.title,
                        image: recipe.image,
                        readyInMinutes: recipe.readyInMinutes,
                        healthScore: recipe.healthScore
                    )
                    filteredRecipeItems.append(recipeItem)
                }
            }

            // Add table item if there are filtered recipe items
            if !filteredRecipeItems.isEmpty {
                //let tableItem = DashBoardTableItem(dashboardItems: [], recipeItems: filteredRecipeItems, cuisineItems: [])
                let tableItem = DashBoardTableItem(dashboardItems: filteredRecipeItems)
                filteredDashboardItems.append(tableItem)
            }
        }

        // Print total items in the filtered dashboard
      //  print("Total items in filtered dashboard: \(filteredDashboardItems[1])")

        // Create and return the view model
        let viewModel = DashBoardScreenViewModel(dashboardTableItems: filteredDashboardItems)
        viewController?.displayDashBoardData(viewModel: viewModel)
       // return viewModel
    }

   

   
}
